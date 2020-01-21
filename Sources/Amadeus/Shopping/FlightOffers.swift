import Foundation
import SwiftyJSON

fileprivate let flightOffers = "v1/shopping/flight-offers"

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
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLFlightOffers(data: data)
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
    
    private func generateURLFlightOffers(data:[String:String]) -> String{
        return generateURL(client: self.client, path: flightOffers, data: data)
    }
    
}
