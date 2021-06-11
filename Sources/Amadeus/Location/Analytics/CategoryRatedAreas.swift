import Foundation

public class CategoryRatedAreas {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/location/analytics/category-rated-areas", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
