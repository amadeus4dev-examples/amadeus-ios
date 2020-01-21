# Amadeus Swift SDK


Amadeus provides a set of APIs for the travel industry. Flights, Hotels, Locations and more.

For more details see the [Swist
documentation](https://amadeus4dev.github.io/amadeus-swift/) on
[Amadeus.com](https://developers.amadeus.com).

## Installation


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
        data in
        print("DATA ES: ", data)
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



## Documentation

Amadeus has a large set of APIs, and our documentation is here to get you
started today. Head over to our
[Reference](https://amadeus4dev.github.io/amadeus-swift/) documentation for
in-depth information about every SDK method, it's arguments and return types.


* [Get Started](https://amadeus4dev.github.io/amadeus-swift/) documentation
* [Initialize the SDK](https://amadeus4dev.github.io/amadeus-swift/)
* [Find an Airport](https://amadeus4dev.github.io/amadeus-swift/#airports)
* [Find a Flight](https://amadeus4dev.github.io/amadeus-swift/#flightoffers)
* [Get Flight Inspiration](https://amadeus4dev.github.io/amadeus-swift/#flightoffers)

## Making API calls

This library conveniently maps every API path to a similar path.

For example, `GET /v2/reference-data/urls/checkin-links?airline=BA` would be:

```swift
amadeus.referenceData.urls.checkinLinks.get(data: ["airlineCode": "BA"], onCompletion: {
    data in 
    ...
})
```

Similarly, to select a resource by ID, you can pass in the ID to the **singular** path.

For example,  `GET /v1/shopping/hotel/123/offers/234` would be:

```swift
amaswua.shopping.hotel(hotelId: "E5C6F41E18EDA2E60884A593B4F5BC17625044FC42DA6F2AA25172C4327FC565").offer(offerId: "1234").get(...)

```


## OnCompletion

Every API call returns a `OnCompletion` that either resolves or rejects. Every
resolved API call returns a `JSON` object.

For a failed API call it returns a `JSON` object containing the (parsed or unparsed) response, the request, and an error code.

```swift
amadeus.shopping.flightDestinations.get(data: ["origin": "MAD", "maxPrice": "10000"], onCompletion: {
    data in
     print(data) => The raw body
})
```


## List of supported endpoints

```swift

// Flight Inspiration Search
amadeus.shopping.flightDestinations.get(data: ["origin": "MAD", "maxPrice": "10000"], onCompletion: {
    data in
        ...
})

// Flight Cheapest Date Search
amadeus.shopping.flightDates.get(data:["origin": "LHR", "destination": "PAR"], 
onCompletion: {
    data in
        ...
})

// Flight Low-fare Search
ama.shopping.flightOffers.get(data: ["origin": "MAD", "destination": "LUX", "departureDate": "2018-12-10"], 
onCompletion: {
    data in
        ...
})

// Flight Checkin Links
amadeus.referenceData.urls.checkinLinks.get(
data: ["airlineCode": "BA"], 
onCompletion: {
    data in
        ...
})

// Airline Code Lookup
amadeus.referenceData.airLines.get(data:["airlineCodes": "BA"], 
onCompletion: {
    data in
        ...
})

// Airports and City Search (autocomplete)
// Find all the cities and airports starting by 'LON'
amadeus.referenceData.locations.get(data:["subType": "AIRPORT,CITY", "keyword": "lon"], onCompletion: {
    data in
        ...
})

// Get a specific city or airport based on its id
amadeus.referenceData.location(locationId: "ALHR").get(data:[:], 
onCompletion: {
    data in
        ...
})

// Airport Nearest Relevant Airport
amadeus.referenceData.locations.airports.get(data:["longitude": "49.0000", "latitude": "2.55"], 
onCompletion: {
    data in
        ...
})

// Flight Most Searched Destinations
// Which were the most searched flight destinations from Madrid in August 2017?
amadeus.travel.analytics.airTraffic.searched.get(data:["originCityCode":"MAD", "marketCountryCode": "ES", "searchPeriod": "2017-08"], 
onCompletion: {
    data in
        ...
})

// How many people in Spain searched for a trip from Madrid to New-York in September 2017?
amadeus.travel.analytics.airTraffic.searchedByDestination.get(data:["originCityCode":"MAD", "destinationCityCode":"NYC", "marketCountryCode": "ES", "searchPeriod": "2017-08"], 
onCompletion: {
    data in
        ...
})

// Flight Most Booked Destinations
amadeus.travel.analytics.airTraffic.booked.get(data:["originCityCode": "MAD", "period": "2017-11"], 
onCompletion: {
    data in
        ...
})

// Flight Most Traveled Destinations
amadeus.travel.analytics.airTraffic.traveled.get(data:["originCityCode": "MAD", "period": "2017-11"], 
onCompletion: {
    data in
        ...
})

// Flight Busiest Traveling Period
amadeus.travel.analytics.airTraffic.busiestPeriod.get(data:["cityCode": "MAD", "period": "2017", "direction": "ARRIVING"], 
onCompletion: {
    data in
        ...
})

// Hotel Search API
// Get list of hotels by city code
amadeus.shopping.hotelOffers.get(data:["cityCode": "MAD", "period": "2017"], onCompletion: {
    data in
        ...
})
// Get list of offers for a specific hotel
amadeus.shopping.hotel(hotelId: "SMPARCOL").hotelOffers.get(data:[:], 
onCompletion: {
    data in
        ...
})
amadeus.shopping.hotel('SMPARCOL').hotelOffers.get()
// Confirm the availability of a specific offer for a specific hotel
amadeus.shopping.hotel(hotelId: "SMPARCOL").offer(offerId: "4BA070CE929E135B3268A9F2D0C51E9D4A6CF318BA10485322FA2C7E78C7852E").get(data:[:], 
onCompletion: {
    data in
        ...
})
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

[npmjs]: https://www.npmjs.com/package/amadeus
[travis]: http://travis-ci.org/amadeus4dev/amadeus-swift
[support]: http://developers.amadeus.com/support
