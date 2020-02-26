import Foundation

/// A namespaced client for the `v2/shopping/hotel-offers/` endpoints
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
        self.client.get(path: "v2/shopping/hotel-offers/\(self.hotelId)", params: data, onCompletion: {
                         (response, error) in 
                            onCompletion(response, error)
                    })
    }
}
