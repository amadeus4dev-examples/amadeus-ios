import Foundation
import SwiftyJSON

fileprivate let airLines = "v1/reference-data/airlines"

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
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLAirLines(data: data)
                getRequest(path: path, auth: auth, client: self.client, onCompletion: {
                    data,err  in
                    if let error = err {
                        onCompletion(nil,error)
                    }else{
                        onCompletion(data,nil)
                    }
                })
            }else{
                onCompletion(nil,nil)
            }
        })
    }
    
    private func generateURLAirLines(data:[String:String]) -> String{
        return generateURL(client: self.client, path: airLines, data: data)
    }
}
