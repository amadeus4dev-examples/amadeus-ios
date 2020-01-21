import Foundation
import SwiftyJSON

fileprivate let booked = "v1/travel/analytics/air-traffic/traveled"

/// A namespaced client for the `v1/travel/analytics/air-traffic/booked` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.booked
/// ```
public class Booked{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns a list of air traffic reports based on the number of bookings.
    ///
    ///   ## Example
    ///   Find the air traffic from London in May 2016
    ///
    ///     amadeus.travel.analytics.airTraffic.booked.get(
    ///         originCityCode:"LON",
    ///         period: "2016-05",
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
                let path = self.generateURLBooked(data: data)
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
    
    private func generateURLBooked(data:[String:String]) -> String{
        return generateURL(client: self.client, path: booked, data: data)
    }
}
