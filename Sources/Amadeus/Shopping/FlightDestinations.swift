import Foundation

/// A namespaced client for the `v1/shopping/flight-destinations` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.flightDestinations
/// ```
public class FlightDestinations {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Find the cheapest destinations where you can fly to.
    ///
    ///   ## Example
    ///   Find the cheapest destination from Madrid up to a maximum price
    ///
    ///     amadeus.shopping.flightDestinations.get(
    ///         origin:"NYC",
    ///         maxPrice: 500,
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - origin: `String` City/Airport IATA code from which the flight will depart.
    ///    - maxPrice: `Int` Maximum price of the flight.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/shopping/flight-destinations", params: data, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
