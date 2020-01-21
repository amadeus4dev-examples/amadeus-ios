import Foundation
import SwiftyJSON

fileprivate let searchedByDestination = "v1/travel/analytics/air-traffic/searched/by-destination"

/// A namespaced client for the `v1/travel/analytics/air-traffic/searched/by-destination` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.SearchedByDestination
/// ```
public class SearchedByDestination{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    
    ///
    /// Returns a list of air traffic reports based on the number of people searching.
    ///
    ///   ## Example
    ///   How many people in Spain searched for a trip from Madrid to New-York in September 2017?
    ///
    ///     ama.travel.analytics.airTraffic.searchedByDestination.get(data:
    ///         ["originCityCode":"MAD",
    ///         "destinationCityCode":"NYC",
    ///         "marketCountryCode": "ES",
    ///         "searchPeriod": "2017-08"],
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - originCityCode: `String` IATA code of the origin city - e.g. MAD for Madrid - required
    ///    - destinationCityCode: `String` IATA code of the destination city - e.g. NYC for New-York - required
    ///    - searchPeriod: `String` period when consumers are travelling in YYYY-MM format
    ///    - marketCountryCode: `String` IATA code of the country from which searches were made e.g. ``"ES"`` for Spain
    ///
    /// - Returns:
    ///    `JSON` object
    
    
    
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLSearchedByDestination(data: data)
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
    
    private func generateURLSearchedByDestination(data:[String:String]) -> String{
        return generateURL(client: self.client, path: searchedByDestination, data: data)
    }
}

