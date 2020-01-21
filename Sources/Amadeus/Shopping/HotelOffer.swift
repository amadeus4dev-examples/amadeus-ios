import Foundation
import SwiftyJSON

fileprivate let hotelOffer = "v2/shopping/hoteloffers/:hotel_id"

/// A namespaced client for the `v1/shopping/hotel-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.hotelOffers
/// ```
public class HotelOffer{
    
    private var client: Client
    private var hotelId: String
    
    public init(client:Client, hotelId: String) {
        self.client = client
        self.hotelId = hotelId
    }
    
    
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
        let path = "v2/shopping/hoteloffers/" + self.hotelId + "/"
        return generateURL(client: self.client, path: path, data: data)
    }
    
}
