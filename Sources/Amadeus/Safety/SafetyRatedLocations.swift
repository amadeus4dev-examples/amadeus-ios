import Foundation

public class SafetyRatedLocations {
    private let client: Client
    
    public let bySquare : SafetyRatedLocationsBySquare
    
    public init(client: Client) {
        self.client = client
        bySquare = SafetyRatedLocationsBySquare(client: client)
    }
       
   public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/safety/safety-rated-locations", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
