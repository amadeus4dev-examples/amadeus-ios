import Foundation
import SwiftyJSON

public class FlightOffersSearch {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Get the cheapest flights on a given journey
    ///
    ///   ## Example
    ///   Find the cheapest flights from New-York to Madrid for Summer 2020
    ///
    ///   amadeus.shopping.flightOffersSearch.get(
    ///            params: [
    ///            "originLocationCode": "MAD",
    ///            "destinationLocationCode: "NYC",
    ///            "departureDate": "2019-08-01",
    ///            "returnDate": "2019-08-20",
    ///            "adults": "1",
    ///             onCompletion: {
    ///              (data,error) in ...}
    ///
    /// - Parameters:
    ///     origin: `String` the City/Airport IATA code from which the flight will
    ///           depart. ``"MAD"``, for example for Madrid.
    ///
    ///     destination: `String` the City/Airport IATA code to which the flight is
    ///            going. ``"BOS"``, for example for Boston.
    ///
    ///     departureDate: `String` the date on which to fly out, in `YYYY-MM-DD`
    ///            format
    ///
    ///     adults: `String` the number of adult passengers with age 12 or older
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/shopping/flight-offers", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }

    /// Get the cheapest flights on a given journey.
    ///
    ///   amadeus.shopping.flightOffersSearch.put(
    ///            body: JSONbody
    ///             onCompletion: {
    ///              (data,error) in ...}
    ///
    ///  - body: the parameters to send to the API in JSON format
    ///
    ///  - Returns:
    ///    `JSON` object
    public func post(body: JSON, onCompletion: @escaping AmadeusResponse) {
        client.post(path: "/v2/shopping/flight-offers", body: body, params: [:], onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
