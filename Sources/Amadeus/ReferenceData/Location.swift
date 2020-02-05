import Foundation
import SwiftyJSON

/// A namespaced client for the `v2/reference-data/locations` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations
/// ```
public class Location{
    
    private let client: Client
    private let locationId: String
    
    public init(client:Client, locationId:String) {
        self.client = client
        self.locationId = locationId
    }
    
    /// Returns a list of airports and cities matching a given keyword.
    ///
    ///   ## Example
    ///   Find any location starting with 'lon'
    ///
    ///     amadeus.referenceData.locations.get(
    ///         subType:"AIRPORT,CITY",
    ///         keyword:"lon",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - subType: `String` Type of location to search for
    ///    - keyword: `String` That should represent the start of a word in a city or airport name or code.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let endpoint = "v1/reference-data/locations/" + self.locationId
                let path = generateURL(client: self.client, path: endpoint, data: data)
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
}
