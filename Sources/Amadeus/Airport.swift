import Foundation

/// A namespaced client for the `v1/airport/` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.airport
/// ```
public class Airport {
    public let predictions: Predictions

    public init(client: Client) {
        predictions = Predictions(client: client)
    }
}
