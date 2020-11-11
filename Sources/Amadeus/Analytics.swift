import Foundation

/// A namespaced client for the `v1/analytics/` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.analytics
/// ```
public class Analytics {
    public let itineraryPriceMetrics: ItineraryPriceMetrics

    public init(client: Client) {
        itineraryPriceMetrics = ItineraryPriceMetrics(client: client)
    }
}
