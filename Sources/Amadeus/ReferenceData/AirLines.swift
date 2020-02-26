import Foundation
import SwiftyJSON

/// A namespaced client for the `v1/reference-data/airlines` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.airLines
/// ```
public class AirLines{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns the airline name and code.
    ///
    ///   ## Example
    ///   Find to which airlines belongs IATA Code BA
    ///
    ///     amadeus.referenceData.airlines.get(
    ///         airlineCodes:"BA",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - airlineCodes: `String` Code of the airline following IATA standard
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        self.client.get(path: "v1/reference-data/airlines", params: data, onCompletion: {
                         (response, error) in 
                            onCompletion(response, error)
                    })
    }
}
