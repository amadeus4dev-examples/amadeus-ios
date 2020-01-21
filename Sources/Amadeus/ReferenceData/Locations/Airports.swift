import Foundation
import SwiftyJSON

fileprivate let airports = "v1/reference-data/locations/airports"

/// A namespaced client for the `v2/reference-data/locations/airports` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations.airports
/// ```
public class Airports{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns a list of relevant airports near to a given point.
    ///
    ///   ## Example
    ///   Find the nearest airport to the 49.0000,2.55 lat/long
    ///
    ///     amadeus.referenceData.locations.airports.get(
    ///         longitude:49.0000,
    ///         latitude:2.55,
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - longitude: `Double` longitude location to be at the center of the search circle.
    ///    - latitude: `Double` latitude location to be at the center of the search circle.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLAirport(data: data)
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
    
    private func generateURLAirport(data:[String:String]) -> String{
        return generateURL(client: self.client, path: airports, data: data)
    }
        
}
