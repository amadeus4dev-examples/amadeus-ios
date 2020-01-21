import Foundation
import SwiftyJSON

fileprivate let hotelOffers = "v2/shopping/hotel-offers"

/// A namespaced client for the `v1/shopping/hotel-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.hotelOffers
/// ```
public class HotelOffers{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Find the list of hotels for a dedicated city.
    ///
    ///   ## Example
    ///   Search for hotels in Paris
    ///
    ///     amadeus.shopping.hotelOffers.get(
    ///         cityCode:"PAR",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - origin: `String` City IATA code.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLHotelOffers(data: data)
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
    
    private func generateURLHotelOffers(data:[String:String]) -> String{
        return generateURL(client: self.client, path: hotelOffers, data: data)
    }
    
}
