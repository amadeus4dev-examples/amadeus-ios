import Foundation

public class OnTime{
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Get the percentage of on-time flight departures from a given airport
    ///
    /// - Returns:
    ///    `JSON` object
    ///

    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/airport/predictions/on-time", params: data, onCompletion: {
                       response, error in
                       onCompletion(response, error)
                   })
    }
}
