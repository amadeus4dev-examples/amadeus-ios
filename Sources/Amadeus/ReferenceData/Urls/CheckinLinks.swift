import Foundation
import SwiftyJSON

fileprivate let checkinLinks = "v2/reference-data/urls/checkin-links"

/// A namespaced client for the `v2/reference-data/urls/checkin-links` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.urls.checkinLinks
/// ```
public class CheckinLinks{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Returns the checkin links for an airline.
    ///
    ///   ## Example
    ///   Find a the checkin links for Air France
    ///
    ///     amadeus.referenceData.urls.checkinLinks.get(
    ///         airlineCode:"AF",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - airlineCode: `String` Airline ID.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLCheckinLinks(data: data)
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
    
    private func generateURLCheckinLinks(data:[String:String]) -> String{
        return generateURL(client: self.client, path: checkinLinks, data: data)
    }
}
