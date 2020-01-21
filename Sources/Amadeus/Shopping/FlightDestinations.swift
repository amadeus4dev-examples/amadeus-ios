import Foundation
import SwiftyJSON

fileprivate let flightDestinations = "v1/shopping/flight-destinations"

/// A namespaced client for the `v1/shopping/flight-destinations` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping.flightDestinations
/// ```
public class FlightDestinations{
    
    private var client: Client
    
    public init(client:Client) {
        self.client = client
    }
    
    
    /// Find the cheapest destinations where you can fly to.
    ///
    ///   ## Example
    ///   Find the cheapest destination from Madrid up to a maximum price
    ///
    ///     amadeus.shopping.flightDestinations.get(
    ///         origin:"NYC",
    ///         maxPrice: 500,
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - origin: `String` City/Airport IATA code from which the flight will depart.
    ///    - maxPrice: `Int` Maximum price of the flight.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String:String], onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.generateURLFlightDestinations(data: data)
                getRequest(path: path, auth: auth, client: self.client, onCompletion: {
                    data,err  in
                    if let error = err {
                        onCompletion(nil,error)
                    }else{
                        print(data)
                        onCompletion(data,nil)
                    }
                })
            }else{
                onCompletion(nil,nil)
            }
        })
    }
    
    private func generateURLFlightDestinations(data:[String:String]) -> String{
        return generateURL(client: self.client, path: flightDestinations, data: data)
    }
    
}
