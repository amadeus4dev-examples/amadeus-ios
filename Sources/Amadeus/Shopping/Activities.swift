import Foundation

public class Activities {
    private let client: Client
    public let bySquare: ActivitiesBySquare
    
    public init(client: Client) {
        self.client = client
        bySquare = ActivitiesBySquare(client: client)
    }
    
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/shopping/activities", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
