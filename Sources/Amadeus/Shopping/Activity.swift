import Foundation

public class Activity {
    private let client: Client
    private let activityId: String
    
    public init(client: Client, activityId: String) {
        self.client = client
        self.activityId = activityId
    }
    
   public func get(onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/shopping/activities/\(activityId)", params: [:], onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
