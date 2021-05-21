
import Foundation
import SwiftyJSON

public class FlightAvailabilities {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Gets available seats in different fare classes
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func post(body: JSON, params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        
        client.post(path: "/v1/shopping/availability/flight-availabilities", body: body, params: params, onCompletion: { result in
            onCompletion(result)
        })
    }
}
