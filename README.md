# Amadeus Swift SDK

[![Travis CI](https://travis-ci.org/amadeus4dev/amadeus-swift.svg?branch=master)](https://travis-ci.org/amadeus4dev/amadeus-swift)

Amadeus provides a set of APIs for the travel industry. Flights, Hotels, Locations and more.

For more details see the Swift documentation on [Amadeus.com](https://developers.amadeus.com).

## Installation

The SDK can be installed via [Swift Package Manager](https://swift.org/package-manager). Edit the `Package.swift`
manifest file inside the directory where your project is located and add:

`amadeus-swift` as dependency:

```swift
    import PackageDescription

    let package = Package(
        name: "YOUR_PROJECT_NAME",
        dependencies: [
            .package(url: "https://github.com/amadeus4dev/amadeus-swift.git", from: "1.0.0"),
        ]
    )
```
Then run `swift build` whenever you get prepared.

## Getting Started

To make your first API call you will need to [register for an Amadeus Developer
Account](https://developers.amadeus.com/create-account) and [set up your first
application](https://developers.amadeus.com/my-apps).

```swift
var amadeus: Amadeus!

amadeus = Amadeus(
    client_id: "REPLACE_BY_YOUR_API_KEY",
    client_secret: "REPLACE_BY_YOUR_API_SECRET"
)

amadeus.referenceData.urls.checkinLinks.get(
    data: ["airlineCode": "BA"],
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
// Initialize using parameters
var amadeus: Amadeus!
amadeus = Amadeus(
    client_id: "REPLACE_BY_YOUR_API_KEY",
    client_secret: "REPLACE_BY_YOUR_API_SECRET"
)
```

Alternatively it can be initialized without any parameters if the environment
variables `AMADEUS_CLIENT_ID` and `AMADEUS_CLIENT_SECRET` are present.

```swift
var amadeus = new Amadeus();
```

Your credentials can be found on the [Amadeus
dashboard](https://developers.amadeus.com/my-apps). [Sign
up](https://developers.amadeus.com/create-account) for an account today.


## Making API calls

This library conveniently maps every API path to a similar path.

For example, `GET /v2/reference-data/urls/checkin-links?airline=BA` would be:

```swift
  amadeus.referenceData.urls.checkinLinks.get(data: ["airlineCode": "BA"], onCompletion: {
     data,error in 
     ...
})
```

Similarly, to select a resource by ID, you can pass in the ID to the
singular path.

For example, ``GET /v2/shopping/hotel-offers/XZY`` would be:

```swift
  amadeus.shopping.hotelOffer(hotelId: "XZY").get(data:[:], 
            onCompletion: {
               (data,error) in 
               ...
}
```

## Response

Every API call returns a `OnCompletion` that either resolves or rejects. Every
resolved API call returns a `JSON` object.

If the API call contained a JSON response it will parse the JSON into the
``.result`` attribute.  If this data also contains a ``data`` key, it will make
that available as the ``.data`` attribute. The raw body of the response is
always available as the ``.body`` attribute.

```swift
amadeus.shopping.flightDestinations.get(data: ["origin": "MAD", "maxPrice": "10000"], onCompletion: {
    result,error in

      print(result.body) // => The raw response, as a string
      print(result.data) // => JSON data field extracted from the JSON
      print(result.result) // => The body parsed as JSON, if the result was parsable
      print(result.statusCode) => HTTP Status code
})
```

## Pagination


If an API endpoint supports pagination, the other pages are available
under the ``.next``, ``.previous``, ``.last`` and ``.first`` methods.


```swift
amadeus.referenceData.locations.airports.get(data:["longitude": "2.55",
                                                   "latitude": "49.0000"], onCompletion: {
    (data, error) in
      amadeus.next(data: data!, onCompletion: {
        (data, err) in
            ....
})
```

If a page is not available, the method will return ``null``.


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

// Flight Inspiration Search
amadeus.shopping.flightDestinations.get(data: ["origin": "BOS", 
                                               "maxPrice": "10000"], onCompletion: {

// Flight Cheapest Date Search
amadeus.shopping.flightDates.get(data:["origin": "LHR",
                                       "destination": "PAR"], onCompletion: {

// Flight Low-fare Search
ama.shopping.flightOffers.get(data: ["origin": "MAD",
                                     "destination": "BER",
                                     "departureDate": "2020-04-10"], onCompletion: {

// Flight Checkin Links
amadeus.referenceData.urls.checkinLinks.get(data: ["airlineCode": "BA"], onCompletion: {

// Airline Code Lookup
amadeus.referenceData.airLines.get(data:["airlineCodes": "BA"], onCompletion: {

// Airports and City Search
amadeus.referenceData.locations.get(data:["subType": "AIRPORT,CITY",
                                          "keyword": "lon"], onCompletion: {

// Get a specific city or airport based on its id
amadeus.referenceData.location(locationId: "ALHR").get(data:[:], onCompletion: {
})

// Airport Nearest Relevant Airport
amadeus.referenceData.locations.airports.get(data:["longitude": "49.0000",
                                                   "latitude": "2.55"], onCompletion: {

// Flight Most Booked Destinations
amadeus.travel.analytics.airTraffic.booked.get(data:["originCityCode": "MAD",
                                                     "period": "2017-11"], onCompletion: {

// Flight Most Traveled Destinations
amadeus.travel.analytics.airTraffic.traveled.get(data:["originCityCode": "MAD",
                                                       "period": "2018-11"], onCompletion: {

// Flight Busiest Traveling Period
amadeus.travel.analytics.airTraffic.busiestPeriod.get(data:["cityCode": "MAD",
                                                            "period": "2018",
                                                            "direction": "ARRIVING"], onCompletion: {

// Hotel Search API

// Get list of hotels by city code
amadeus.shopping.hotelOffers.get(data:["cityCode": "MAD"], onCompletion: {

// Get list of offers for a specific hotel
amadeus.shopping.hotelOfferByHotel.get(data:["hotelId": "BGMILBGB",
                                             "roomQuantity": "1"], onCompletion: {

// Confirm the availability of a specific offer for a specific hotel
amadeus.shopping.hotelOffer(hotelId: "foobar").get(data:[:], onCompletion: {
```

## Development & Contributing

Want to contribute? Read our [Contributors Guide](.github/CONTRIBUTING.md) for
guidance on installing and running this code in a development environment.

## License

This library is released under the [MIT License](LICENSE).

## Help

Our [developer support team](https://developers.amadeus.com/support) is here to
help you. You can find us on
[StackOverflow](https://stackoverflow.com/questions/tagged/amadeus) and
[email](mailto:developers@amadeus.com).

[travis]: http://travis-ci.org/amadeus4dev/amadeus-swift
[support]: http://developers.amadeus.com/support
