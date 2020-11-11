import Foundation

/// A namespaced client for the `v1/travel/` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel
/// ```
public class Travel {
    public let analytics: TravelAnalytics
    public let predictions: Predictions
    public let tripParserJobs: TripParserJobs

    public init(client: Client) {
        analytics = TravelAnalytics(client: client)
        predictions = Predictions(client: client)
        tripParserJobs = TripParserJobs(client: client)
    }
}
