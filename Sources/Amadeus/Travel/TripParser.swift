import Foundation
import SwiftyJSON

public class TripParser {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Sends the request for the parsing with the
    /// booking details and input parameters.
    public func post(body: JSON, onCompletion: @escaping AmadeusResponse) {
        client.post(path: "/v3/travel/trip-parser", body: body, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
