import Foundation

public class SafetyRatedLocation {
    private let client: Client
    private let locationId: String
    
    public init(client: Client, locationId: String) {
        self.client = client
        self.locationId = locationId
    }
    
   public func get(onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/safety/safety-rated-locations/\(locationId)", params: [:], onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
