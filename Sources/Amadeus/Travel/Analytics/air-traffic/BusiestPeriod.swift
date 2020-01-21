import Foundation
import SwiftyJSON

fileprivate let busiestPeriod = "v1/travel/analytics/air-traffic/busiest-period"

/// A namespaced client for the `v1/travel/analytics/air-traffic/busiest-period` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.busiestPeriod
/// ```
public class BusiestPeriod{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns a list of air traffic reports.
    ///
    ///   ## Example
    ///   Find the air traffic for travelers arriving in Paris in 2017
    ///
    ///     amadeus.travel.analytics.airTraffic.busiestPeriod.get(
    ///         cityCode:"PAR",
    ///         period: "2017",
    ///         direction: "arriving",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - cityCode: `String` IATA code of the origin city.
    ///    - period: `String` period when consumers are travelling in `YYYY` format
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLBusiestPeriod(data: data)
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
    
    private func generateURLBusiestPeriod(data:[String:String]) -> String{
        return generateURL(client: self.client, path: busiestPeriod, data: data)
    }
}
