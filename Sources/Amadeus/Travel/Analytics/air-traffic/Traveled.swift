import Foundation
import SwiftyJSON

fileprivate let traveled = "v1/travel/analytics/air-traffic/traveled"

/// A namespaced client for the `v1/travel/analytics/air-traffic/traveled` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.traveled
/// ```
public class Traveled{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns a list of air traffic reports based on the number of people traveling.
    ///
    ///   ## Example
    ///   Find the air traffic from Nice in August 2017
    ///
    ///     amadeus.travel.analytics.airTraffic.booked.get(
    ///         originCityCode:"NCE",
    ///         period: "2017-08",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - originCityCode: `String` IATA code of the origin city.
    ///    - period: `String` period when consumers are travelling in `YYYY-MM` format
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLTraveled(data: data)
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
    
    private func generateURLTraveled(data:[String:String]) -> String{
        return generateURL(client: self.client, path: traveled, data: data)
    }
}
