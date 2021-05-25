import Foundation

/// A namespaced client for the `v1/shopping/flight-offers` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.shopping.flightOffers
/// ```
public class FlightOffers {
    public let pricing: FlightOffersPrice
    public let prediction: Prediction
    public let upselling: Upselling

    public init(client: Client) {
        pricing = FlightOffersPrice(client: client)
        prediction = Prediction(client: client)
        upselling = Upselling(client: client)
    }
}

