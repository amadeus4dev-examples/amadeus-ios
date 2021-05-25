import Foundation

/// A namespaced client for the `v1/shopping/availability` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.availability
/// ```
public class Availability {
    public let flightAvailabilities: FlightAvailabilities

    public init(client: Client) {
        flightAvailabilities = FlightAvailabilities(client: client)
    }
}
