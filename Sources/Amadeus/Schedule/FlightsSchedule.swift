import Foundation

public class FlightsSchedule {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }

    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/schedule/flights", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
