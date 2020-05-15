# Amadeus iOS SDK

[![Travis CI](https://travis-ci.org/amadeus4dev/amadeus-ios.svg?branch=master)](https://travis-ci.org/amadeus4dev/amadeus-ios) ![Platform](https://img.shields.io/badge/platforms-macOS%2010.10%20%7C%20-F28D00.svg) 


Amadeus has a large set of APIs, and our documentation is here to get you started today. For more details, check out the [Amadeus for Developers Portal](https://developers.amadeus.com).

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
            .package(url: "https://github.com/amadeus4dev/amadeus-ios.git", from: "1.0.0"),
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
    onCompletion: {
       (result, error) in
       if error == nil {
         print("Data ", result?.data)
       }
    }
)
```

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
  amadeus.referenceData.urls.checkinLinks.get(params: ["airlineCode": "BA"], onCompletion: {
     (data,error) in 
     ...
   })
```

Similarly, to select a resource by ID, you can pass in the ID to the singular path. For example, `GET /v2/shopping/hotel-offers/XZY` would be:

```swift
  amadeus.shopping.hotelOffer(hotelId: "XZY").get(params:[:], 
            onCompletion: {
               (data,error) in 
               ...
    })
```
You can make any arbitrary API call directly with the `.get` method as well:

```swift
  amadeus.get(path:'/v2/reference-data/urls/checkin-links',
              params: ["airlineCode":"BA"], onCompletion: {
                (data,error) in
                 ....
    })
```

Or, with `POST` using the `.post` method:

```swift
  amadeus.post(path: '/v2/shopping/flight-offers', body: body, params: [:],
    onCompletion: {
            (response, error) in
              ...
      })
```

## Response

Responses are based on [swift closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html), that are self-contained blocks of functionality that can be passed around and used in your code.

Every API call returns a `OnCompletion` closure that either resolves or rejects. Every resolved API call returns a `JSON` object.

If the API call contained a JSON response, it will parse the JSON into `.result` attribute.  If it also contains a `data` key, that is made available in `.data` attribute. The raw body of the response is always available in `.body` attribute.

```swift
amadeus.shopping.flightDestinations.get(params: ["origin": "MAD", "maxPrice": "10000"], onCompletion: {
    result,error in

      print(result.body)       // => The raw response, as a string
      print(result.data)       // => JSON data field extracted from the JSON
      print(result.result)     // => The body parsed as JSON, if the result was parsable
      print(result.statusCode) // => HTTP Status code
})
```

## Pagination


If an API endpoint supports pagination, the other pages are available under the `.next`, `.previous`, `.last` and `.first` methods.


```swift
amadeus.referenceData.locations.airports.get(params:["longitude": "2.55",
                                                   "latitude": "49.0000"], onCompletion: {
    (data, error) in
      amadeus.next(response: data!, onCompletion: {
        (data, err) in
            ....
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

// Seatmap Display
amadeus.shopping.seatMaps.get(params: ["flight-orderId":"eJzTd9f3NjIJdzUGAAp%2fAiY="],
                              onCompletion: { ... })

amadeus.shopping.seatMaps.post(body: body, onCompletion: { ... })

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

## Development & Contributing

Want to contribute? Read our [Contributors Guide](.github/CONTRIBUTING.md) for guidance on installing and running this code in a development environment.

## License

This library is released under the [MIT License](LICENSE).

## Help

Our [developer support team](https://developers.amadeus.com/support) is here to help you. You can also find us on [StackOverflow](https://stackoverflow.com/questions/tagged/amadeus) and [email](mailto:developers@amadeus.com).

[travis]: http://travis-ci.org/amadeus4dev/amadeus-ios
[support]: http://developers.amadeus.com/support
