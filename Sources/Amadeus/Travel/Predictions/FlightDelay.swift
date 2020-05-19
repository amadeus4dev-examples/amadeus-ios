import Foundation

/// A namespaced client for the `v1/travel/predictions/flight-delay` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.predictions.flightDelay
/// ```
public class FlightDelay {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Will there be a delay from BRU to FRA? If so how much delay?
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/travel/predictions/flight-delay", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
