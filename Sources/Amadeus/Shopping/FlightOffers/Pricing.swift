import Foundation
import SwiftyJSON

public class FlightOffersPrice {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Gets a confirmed price and availability of a flight
    ///
    /// - Returns:
    ///    `JSON` object
    ///
   public func post(body: JSON, onCompletion: @escaping AmadeusResponse) {

       var flightOffers: JSON = body

       if body.arrayValue.count == 0 {
           flightOffers = [body]
       }

       let pricing: JSON = [ "data": [ "type": "flight-offers-pricing", "flightOffers": flightOffers] ]

       client.post(path: "/v1/shopping/flight-offers/pricing", body: pricing, onCompletion: {
                       response, error in
                       onCompletion(response, error)
                   })
   }
}
