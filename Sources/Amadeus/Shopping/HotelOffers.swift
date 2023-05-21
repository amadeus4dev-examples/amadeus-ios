import Foundation

/// A namespaced client for the `v1/shopping/hotel-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.hotelOffers
/// ```
public class HotelOffers {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Find the list of hotels for a dedicated city.
    ///
    ///   ## Example
    ///   Search for hotels in Paris
    ///
    ///     amadeus.shopping.hotelOffers.get(
    ///         params: [cityCode:"PAR"],
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - origin: `String` City IATA code.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v3/shopping/hotel-offers", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
