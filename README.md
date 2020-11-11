# Amadeus iOS SDK

[![Travis CI](https://travis-ci.org/amadeus4dev/amadeus-ios.svg?branch=master)](https://travis-ci.org/amadeus4dev/amadeus-ios) [![Discord](https://img.shields.io/discord/696822960023011329?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/cVrFBqx)


Amadeus has a rich set of APIs for the travel industry. For more details, check out the [Amadeus for Developers Portal](https://developers.amadeus.com).

## Prerequisites

- Swift 5.0 or higher
- Xcode 11.0+

## Installation

The SDK can be installed via [Swift Package Manager](https://swift.org/package-manager). Edit the `Package.swift` manifest file (located inside the project directory), and add the `amadeus-ios` dependency:

```swift
    import PackageDescription

    let package = Package(
        name: "YOUR_PROJECT_NAME",
        dependencies: [
            .package(url: "https://github.com/amadeus4dev/amadeus-ios.git", from: "1.2.0"),
        ]
    )
```
Then, run `swift build` when ready.

## Getting Started

To make your first API call, you will need to [register](https://developers.amadeus.com/register) for an Amadeus Developer account and [set up your first application](https://developers.amadeus.com/my-apps).

```swift
import amadeus

var amadeus: Amadeus!

amadeus = Amadeus(
    client_id: "REPLACE_BY_YOUR_API_KEY",
    client_secret: "REPLACE_BY_YOUR_API_SECRET"
)

amadeus.referenceData.urls.checkinLinks.get(
        params: ["airlineCode": "BA"],
        onCompletion: { result in
            switch result {
              case .success(let response):
                 print(response.data)
              case .failure(let error):
                 print(error.localizedDescription)
           }
})
```

Examples
--------------------------
You can find all the endpoints in self-contained [code examples](https://github.com/amadeus4dev/amadeus-code-examples).

## Initialization

The client can be initialized directly.

```swift
import amadeus

// Initialize using parameters
var amadeus: Amadeus!

amadeus = Amadeus(
    client_id: "REPLACE_BY_YOUR_API_KEY",
    client_secret: "REPLACE_BY_YOUR_API_SECRET"
)
```

Alternatively, it can be initialized without any parameters if the environment variables `AMADEUS_CLIENT_ID` and `AMADEUS_CLIENT_SECRET` are present.

```swift
 var amadeus = Amadeus()
```

Your credentials can be found on the [Amadeus dashboard](https://developers.amadeus.com/my-apps).

By default, the SDK environment is set to `test` environment. To switch to `production` (pay-as-you-go) environment, please switch the hostname as follows:

```swift
 var amadeus = Amadeus(environment: ["hostname": "production"])
```

## Making API calls

This library conveniently maps every API path to a similar path. For example, `GET /v2/reference-data/urls/checkin-links?airline=BA` would be:

```swift
     amadeus.referenceData.urls.checkinLinks.get(params: ["airlineCode": "BA"],
                                                 onCompletion: { result in
         switch result {
             case .success(let response):
                // do something
             case .failure(let error):
                // do something else
            }
```

Similarly, to select a resource by ID, you can pass in the ID to the singular path. For example, `GET /v2/shopping/hotel-offers/XZY` would be:

```swift
  amadeus.shopping.hotelOffer(hotelId: "XZY").get(onCompletion: { result in 
```

You can make any arbitrary `GET` API call directly with the `.get` method as well:

```swift
  amadeus.get(path:'/v2/reference-data/urls/checkin-links',
              params: ["airlineCode":"BA"], onCompletion: {
                result in
                 ....
    })
```

Or, with `POST` using the `.post` method:

```swift
  amadeus.post(path: '/v2/shopping/flight-offers', body: body, params: [:],
    onCompletion: {
            result in
              ...
      })
```

## Response

Responses are based on [swift
closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html), that
are self-contained blocks of functionality that can be passed around and used
in your code.

Every API call response is handled by the `OnCompletion` closure which returns
a [Result](https://developer.apple.com/documentation/swift/result) value that
represents either a success, which contains the `JSON` object, or a failure,
containing the error.

If the API call contained a JSON response, the SDK will parse that JSON into
`.result` attribute.  If it contains a `data` key, that is made available in
`.data` attribute. The raw body of the response is always available in `.body`
attribute.

```swift
amadeus.shopping.flightDestinations.get(params: ["origin": "NYC", "maxPrice": "10000"],
    onCompletion: { result in
       switch result {
           case .success(let response):
                print(response.body)       // => The raw response, as a string
                print(response.data)       // => JSON data field extracted from the JSON
                print(response.result)     // => The body parsed as JSON, if the result was parsable
                print(response.statusCode) // => HTTP Status code
})
```

## Pagination


If an API endpoint supports pagination, the other pages are available under the `.next`, `.previous`, `.last` and `.first` methods.


```swift
amadeus.referenceData.locations.airports.get(params:["longitude": "2.55",
                                                     "latitude": "49.0000"], 
                                             onCompletion: { result in
    switch result {
        case .success(let response):
            amadeus.next(response: response, onCompletion: { result in
                switch result {
                    case .success(let response):
                       // do something
})
```

If a page is not available, the method will return `null`.


## Logging & Debugging

The SDK makes it easy to debug your API calls.

```swift
var amadeus: Amadeus!

amadeus = Amadeus(
    client_id: "REPLACE_BY_YOUR_API_KEY",
    client_secret: "REPLACE_BY_YOUR_API_SECRET",
    environment: ["log_level" : "debug"])
)
```

## List of supported endpoints

```swift

// Fligh Offers Search
amadeus.shopping.flightOffersSearch.get(params: ["originLocationCode": "MAD",
                                               "destinationLocationCode": "BER",
                                               "departureDate": "2020-05-16",
                                               "returnDate": "2020-05-30",
                                               "adults": "2"], onCompletion: { ... })

amadeus.shopping.flightOffersSearch.post(body: jsonBody, onCompletion: { ... })

// Flight Offers Price
amadeus.shopping.flightOffers.pricing.post(body: jsonBody, onCompletion: { ... })

// Flight Create Orders
amadeus.booking.flightOrders.post(body: jsonBody, onCompletion: { ... })

// Flight Order Management (Retrieve)
amadeus.booking.flightOrder(flightOrderId: "eJzTd9f3NjIJdzUGAAp%2fAiY=").get(
                                 onCompletion: { ... })

// Flight Order Management (Delete)
amadeus.booking.flightOrder(flightOrderId: "eJzTd9f3NjIJdzUGAAp%2fAiY=").delete(
                                 onCompletion: { ... })

// Flight Inspiration Search
amadeus.shopping.flightDestinations.get(params: ["origin": "BOS", 
                                               "maxPrice": "10000"], onCompletion: { ... })

// Flight Cheapest Date Search
amadeus.shopping.flightDates.get(params:["origin": "LHR",
                                       "destination": "PAR"], onCompletion: { ... })


// On demand flight status
amadeus.schedule.flights.get(params:["carrierCode":"AZ",
                                     "flightNumber":"319",
                                     "scheduledDepartureDate":"2021-03-13"], onCompletion: { ... })

// Seatmap Display
amadeus.shopping.seatMaps.get(params: ["flight-orderId":"eJzTd9f3NjIJdzUGAAp%2fAiY="],
                              onCompletion: { ... })

amadeus.shopping.seatMaps.post(body: body, onCompletion: { ... })

// Flight Price Analysis
amadeus.analytics.itineraryPriceMetrics.get(params: ["originIataCode": "MAD",
                                                     "destinationIataCode": "CDG",
                                                     "departureDate": "2021-01-15"],
                                            onCompletion: { ... })

// Airport On-Time Performance
amadeus.airport.predictions.onTime.get(params: ["airportCode": "JFK"], onCompletion: { ... })

// Flight Delay Prediction
amadeus.travel.predictions.flightDelay.get(params: ["originLocationCode": "NCE",
                                                  "destinationLocationCode": "IST",
                                                  "departureDate":"2020-08-01",
                                                  "departureTime":"18:20:00",
                                                  "arrivalDate":"2020-08-01",
                                                  "arrivalTime":"22:15:00",
                                                  "aircraftCode":"321",
                                                  "carrierCode":"TK",
                                                  "flightNumber":"1816",
                                                  "duration":"PT31H10M"],
                                                       onCompletion: { ... })

// Flight Choice Prediction
amadeus.shopping.flightOffers.prediction.post(body: jsonBody, onCompletion: { ... })

// Travel Recommendations
amadeus.referenceData.recommendedLocations.get(params: ["cityCodes": "MAD,BER"], onCompletion: { ... })

// Flight Checkin Links
amadeus.referenceData.urls.checkinLinks.get(params: ["airlineCode": "BA"], onCompletion: { ... })

// Airline Code Lookup
amadeus.referenceData.airLines.get(params:["airlineCodes": "BA"], onCompletion: { ... })

// Airports and City Search
amadeus.referenceData.locations.get(params:["subType": "AIRPORT,CITY",
                                          "keyword": "lon"], onCompletion: { ... })

// Get a specific city or airport based on its id
amadeus.referenceData.location(locationId: "ALHR").get(params:[:], onCompletion: { ... })

// Airport Nearest Relevant Airport
amadeus.referenceData.locations.airports.get(params:["longitude": "49.0000",
                                                   "latitude": "2.55"], onCompletion: { ... })

// Flight Most Booked Destinations
amadeus.travel.analytics.airTraffic.booked.get(params:["originCityCode": "MAD",
                                                     "period": "2017-11"], onCompletion: { ... })

// Flight Most Traveled Destinations
amadeus.travel.analytics.airTraffic.traveled.get(params:["originCityCode": "MAD",
                                                       "period": "2018-11"], onCompletion: { ... })

// Flight Busiest Traveling Period
amadeus.travel.analytics.airTraffic.busiestPeriod.get(params:["cityCode": "MAD",
                                                            "period": "2018",
                                                            "direction": "ARRIVING"], onCompletion: { ... })

// Hotel APIs

// Get list of hotels by city code
amadeus.shopping.hotelOffers.get(params:["cityCode": "MAD"], onCompletion: { ... })

// Get list of offers for a specific hotel
amadeus.shopping.hotelOfferByHotel.get(params:["hotelId": "BGMILBGB",
                                             "roomQuantity": "1"], onCompletion: { ... })

// Confirm the availability of a specific offer for a specific hotel
amadeus.shopping.hotelOffer(hotelId: "foobar").get(params:[:], onCompletion: { ... })

// Book the offer retrieved from Hotel Search API.
amadeus.booking.hotelBookings.post(body: body, onCompletion: { ... })

// Get ratings and sentiment scores for hotels.
amadeus.eReputation.hotelSentiments.get(params: ["hotelIds": "TELONMFS,ADNYCCTB,XXXYYY01"],
                                        onCompletion: { ... })

// Destination Content

// Returns a list of relevant points of interest near to a given point.
amadeus.referenceData.locations.pointsOfInterest.get(params: ["latitude": "41.397158",
                                                            "longitude": "2.160873",
                                                            "radius": "2"], onCompletion: { ... })

// Returns a list of relevant point of interests around 4 points
amadeus.referenceData.locations.pointsOfInterest.bySquare.get(params: ["north": "41.397158",
                                                                     "west": "2.160873",
                                                                     "south": "41.394582",
                                                                     "east": "2.177181"],
                                                                onCompletion: { ... })

// Retrieve a point of interest by its id
amadeus.referenceData.locations.pointOfInterest(poiId: "8DA7B6CDCA").get(onCompletion: { ... })


// Safe Place API
amadeus.safety.safetyRatedLocations.get(params: ["latitude": "41.397158",
                                                 "longitude": "2.160873",
                                                 "radius": "2"], onCompletion: { ... })

// Safe Place API By Square
amadeus.safety.safetyRatedLocations.bySquare.get(params: ["north": "41.397158",
                                                          "west": "2.160873",
                                                          "south": "41.394582",
                                                          "east": "2.177181"],
                                                        onCompletion: { ... })

// Safe Place API by Id
amadeus.safety.safetyRatedLocation(locationId: "Q930402753").get(onCompletion: { ... })


// Tours and Activities
amadeus.shopping.activities.get(params: ["latitude": "41.397158",
                                         "longitude": "2.160873"], 
                                        onCompletion: { ... })


// Tours and Activities by Square
amadeus.shopping.activities.bySquare.get(params: ["north": "41.397158",
                                                  "west": "2.160873",
                                                  "south": "41.394582",
                                                  "east": "2.177181"],
                                                  onCompletion: { ... })


// Tours and Activities by Id
amadeus.shopping.activity(activityId: "56777").get(onCompletion: { ... })


// Trip APIs

// Trip Purpose Prediction
amadeus.travel.predictions.tripPurpose.get(params: ["originLocationCode": "NYC",
                                                  "destinationLocationCode": "MAD",
                                                  "departureDate":"2020-08-01",
                                                  "returnDate":"2020-08-12",
                                                  "searchDate":"2020-06-11"],
                                                  onCompletion: { ... })

// Trip Parser Jobs
amadeus.travel.tripParserJobs.post(body: jsonBody, onCompletion: { ... })

// Trip Parser Jobs, get status
amadeus.travel.tripParserJobs.status(jobId: response.data['id']).get(onCompletion: { ... })

// Trip Parser Jobs, get result
amadeus.travel.tripParserJobs.result(jobId: response.data['id']).get(onCompletion: { ... })

// AI-Generated Photos
amadeus.media.files.generatedPhotos.get(params: ["category": "MOUNTAIN"],
                                        onCompletion: { ... })
```

## License

This library is released under the [MIT License](LICENSE).

## Help

Our [developer support team](https://developers.amadeus.com/support) is here to help you. You can also find us on [StackOverflow](https://stackoverflow.com/questions/tagged/amadeus) and [email](mailto:developers@amadeus.com).

[travis]: http://travis-ci.org/amadeus4dev/amadeus-ios
[support]: http://developers.amadeus.com/support
