import Foundation

public class Safety {
    private let client: Client
    public let safetyRatedLocations : SafetyRatedLocations

    public func safetyRatedLocation(locationId: String) -> SafetyRatedLocation {
        return SafetyRatedLocation(client: client, locationId: locationId)
    }
 
    public init(client: Client) {
        self.client = client
        safetyRatedLocations = SafetyRatedLocations (client: client)
    }
}
