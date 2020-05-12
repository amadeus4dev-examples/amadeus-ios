import Foundation
import SwiftyJSON

public class Prediction {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Returns a list of flight offers with the probability to be chosen.
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func post(body: JSON, params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        client.post(path: "/v2/shopping/flight-offers/prediction",
                    body: body,
                    params: params,
                    onCompletion: { result in
                        onCompletion(result)
        })
    }
}
