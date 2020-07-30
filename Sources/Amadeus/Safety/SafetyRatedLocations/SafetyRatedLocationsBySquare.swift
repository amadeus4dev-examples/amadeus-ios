import Foundation

public class SafetyRatedLocationsBySquare {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
   public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/safety/safety-rated-locations/by-square", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
    
}
