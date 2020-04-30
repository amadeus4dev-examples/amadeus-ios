import Foundation

/// A namespaced client for the `v1/shopping/flight-dates` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.flightDates
/// ```
public class FlightDates {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Find the cheapest destinations where you can fly to.
    ///
    ///   ## Example
    ///   Find the cheapest flight dates from New-York to Madrid
    ///
    ///     amadeus.shopping.flightDates.get(
    ///         origin:"NYC",
    ///         destination: "MAD",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - origin: `String` City/Airport IATA code from which the flight will depart.
    ///    - destination: `String` City/Airport IATA code to which traveler is going.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/shopping/flight-dates", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
