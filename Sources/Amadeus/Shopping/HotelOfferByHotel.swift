import Foundation

/// A namespaced client for the `v1/shopping/hotel-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.hotelOffers
/// ```
public class HotelOfferByHotel {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/shopping/hotel-offers/by-hotel", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
