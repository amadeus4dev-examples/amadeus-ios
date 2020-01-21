import Foundation
import SwiftyJSON

fileprivate let searched = "v1/travel/analytics/air-traffic/searched"

/// A namespaced client for the `v1/travel/analytics/air-traffic/searched` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.busiestPeriod
/// ```
public class Searched{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    ///
    /// Returns a list of air traffic reports based on the number of people searching.
    ///
    ///   ## Example
    ///   Which were the most searched flight destinations from Madrid in August 2017?
    ///
    ///     ama.travel.analytics.airTraffic.searchedByDestination.get(data:
    ///         ["originCityCode":"MAD",
    ///         "marketCountryCode": "ES",
    ///         "searchPeriod": "2017-08"],
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - originCityCode: `String` IATA code of the origin city - e.g. MAD for - required
    ///    - searchPeriod: `String` period when consumers are travelling in YYYY-MM format
    ///    - marketCountryCode: `String` IATA code of the country from which searches were made e.g. ``"ES"`` for Spain
    ///
    /// - Returns:
    ///    `JSON` object
    
    
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLSearched(data: data)
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
    
    private func generateURLSearched(data:[String:String]) -> String{
        return generateURL(client: self.client, path: searched, data: data)
    }
}

