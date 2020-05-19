import Foundation
import SwiftyJSON

public class FlightOrders {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Books a flight
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func post(body: JSON, params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        client.post(path: "/v1/booking/flight-orders", body: body, params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
