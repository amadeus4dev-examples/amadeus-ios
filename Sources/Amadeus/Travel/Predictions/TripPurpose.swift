import Foundation

/// A namespaced client for the `v1/travel/predictions/trip-purpose` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.predictions.tripPurpose
/// ```
public class TripPurpose {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

   public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/travel/predictions/trip-purpose", params: data, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
