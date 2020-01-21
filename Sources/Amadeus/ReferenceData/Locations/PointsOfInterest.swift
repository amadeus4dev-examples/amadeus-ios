import Foundation
import SwiftyJSON

fileprivate let pois = "/v1/reference-data/locations/pois"

/// A namespaced client for the `v1/reference-data/locations/pois` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations.pointsOfInterest
/// ```
public class PointsOfInterest {
    
    private let client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns a list of relevant point of interests near to a given point.
    ///
    ///   ## Example
    ///   Find relevant points of interest close to Barcelona
    ///
    ///   amadeus.referenceData.locations.pointsOfInterest.get(
    ///         longitude: 2.160873,
    ///         latitude: 41.397158,
    ///         onCompletion: {
    ///             (data,error) in ...}
    ///     )
    /// - Parameters:
    ///    - longitude: `double` longitude location to be at the center of the search circle
    ///    - latitude:  `double` latitude location to be at the center of the search circle
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = generateURL(client: self.client, path: pois, data: data)
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
