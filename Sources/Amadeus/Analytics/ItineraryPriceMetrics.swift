import Foundation

public class ItineraryPriceMetrics {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/analytics/itinerary-price-metrics", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
