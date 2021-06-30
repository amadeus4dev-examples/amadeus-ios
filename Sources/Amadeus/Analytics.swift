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
    // Since we cannot have two 'Analytics' classes under the
    // same module, we need to instantiate categoryRatedAreas here even
    // if it belongs to the endpoint location/analytics/category-rated-areas
    public let categoryRatedAreas: CategoryRatedAreas

    public init(client: Client) {
        itineraryPriceMetrics = ItineraryPriceMetrics(client: client)
        categoryRatedAreas = CategoryRatedAreas(client: client)
    }
}
