import Foundation
import SwiftyJSON

fileprivate let locations = "v1/reference-data/locations"

/// A namespaced client for the `v2/reference-data/locations` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations
/// ```
public class Locations{
    
    private let client: Client

    public let airports:Airports
    public let pointsOfInterest:PointsOfInterest
    
    public init(client:Client) {
        self.client = client
        airports = Airports(client: client)
        pointsOfInterest = PointsOfInterest(client: client)
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
                let path = self.generateURLLocations(data: data)
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
    
    private func generateURLLocations(data:[String:String]) -> String{
        return generateURL(client: self.client, path: locations, data: data)
    }
}
