import Foundation

/// A namespaced client for the `v1/shopping/flight-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.flightOffers
/// ```
public class FlightOffers{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    /// Find the cheapest bookable flights for a date.
    ///
    ///   ## Example
    ///   Find the cheapest flights from New-York to Madrid for Summer 2019
    ///
    ///     amadeus.shopping.flightOffers.get(
    ///         origin:"NYC",
    ///         destination:"MAD",
    ///         departureDate:"2018-08-01",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    ///
    /// - Parameters:
    ///     - origin: `String` City/Airport IATA code from which the flight will depart.
    ///     - destination: `String` City/Airport IATA code to which traveler is going.
    ///     - departureDate: `String` The departure date for the flight.
    ///
    /// - Returns:
    ///    `JSON` object
    ///
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        self.client.get(path: "v1/shopping/flight-offers", params: data, onCompletion: {
                         (response, error) in 
                            onCompletion(response, error)
                    })
    }
}
