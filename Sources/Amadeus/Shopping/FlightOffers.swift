import Foundation

/// A namespaced client for the `v1/shopping/flight-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics
/// ```
public class FlightOffers {
    public let pricing: FlightOffersPrice

    public init(client: Client) {
        pricing = FlightOffersPrice(client: client)
    }
}

