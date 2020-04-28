import Foundation

/// A namespaced client for the `v1/e-reputation` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.e-reputation
/// ```
public class EReputation {
    public let hotelSentiments: HotelSentiments

    public init(client: Client) {
        hotelSentiments = HotelSentiments(client: client)
    }
}
