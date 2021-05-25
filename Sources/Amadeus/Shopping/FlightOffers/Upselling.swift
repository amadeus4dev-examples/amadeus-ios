import Foundation
import SwiftyJSON

public class Upselling {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Get available seats in different fare classes
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func post(body: JSON, params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        
        client.post(path: "v1/shopping/flight-offers/upselling", body: body, params: params, onCompletion: { result in
            onCompletion(result)
        })
    }
}
