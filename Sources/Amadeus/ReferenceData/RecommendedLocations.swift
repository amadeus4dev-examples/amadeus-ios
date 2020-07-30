import Foundation

public class RecommendedLocations {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/reference-data/recommended-locations", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
