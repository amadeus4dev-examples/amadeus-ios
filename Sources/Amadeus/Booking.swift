import Foundation

/// A namespaced client for the `v1/booking` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.booking
/// ```
public class Booking {
    public let flightOrders: FlightOrders
   private let client: Client

    public init(client: Client) {
        flightOrders = FlightOrders(client: client)
       self.client = client
    }
}
