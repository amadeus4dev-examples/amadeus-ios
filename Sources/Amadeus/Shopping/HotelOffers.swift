import Foundation

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
        self.client.get(path: "v2/shopping/hotel-offers", params: data, onCompletion: {
                         (response, error) in 
                            onCompletion(response, error)
                    })
    }
}
