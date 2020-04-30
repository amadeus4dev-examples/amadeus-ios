import Foundation

/// A namespaced client for the `v1/booking` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.booking
/// ```
public class Booking {
    private let client: Client
    public let flightOrders: FlightOrders
    public let hotelBookings: HotelBookings

    public init(client: Client) {
        self.client = client
        flightOrders = FlightOrders(client: client)
        hotelBookings = HotelBookings(client: client)
    }

    public func flightOrder(flightOrderId: String) -> FlightOrder{
        return FlightOrder(client: self.client, flightOrderId: flightOrderId)
    }
}
