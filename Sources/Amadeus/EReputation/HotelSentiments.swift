import Foundation

/// A namespaced client for the `v2/e-reputation/hotel-sentiments
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.eReputation.hotelSentiments
/// ```
public class HotelSentiments {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Get the sentiment analysis of hotel reviews
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/e-reputation/hotel-sentiments", params: data, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
