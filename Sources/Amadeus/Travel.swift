import Foundation

/// A namespaced client for the `v1/travel/` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel
/// ```
public class Travel {
    public let analytics: Analytics
    public let predictions: Predictions
    public let tripParserJobs: TripParserJobs

    public init(client: Client) {
        analytics = Analytics(client: client)
        predictions = Predictions(client: client)
        tripParserJobs = TripParserJobs(client: client)
    }
}
