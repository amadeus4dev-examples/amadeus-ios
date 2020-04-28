import Foundation
import SwiftyJSON

public class SeatMaps {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// To retrieve the seat map of each flight present in an order.
    ///
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/shopping/seatmaps", params: data, onCompletion: {
                       response, error in
                       onCompletion(response, error)
                   })
    }

    /// To retrieve the seat map of each flight present in an order.
    ///
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func post(body: JSON, onCompletion: @escaping AmadeusResponse) {
        client.post(path: "v1/shopping/seatmaps", body: body, params: [:], onCompletion: {
                        response, error in
                        onCompletion(response, error)
                    })
    }
}
