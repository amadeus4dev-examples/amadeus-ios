import Foundation

/// A namespaced client for the `v1/shopping` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.shopping
/// ```
public class Shopping {
    public let flightOffersSearch: FlightOffersSearch
    public let flightDestinations: FlightDestinations
    public let flightDates: FlightDates
    public let flightOffers: FlightOffers
    public let hotelOffers: HotelOffers
    public let hotelOfferByHotel: HotelOfferByHotel
    private let client: Client

    public init(client: Client) {
        flightOffersSearch = FlightOffersSearch(client: client)
        flightDestinations = FlightDestinations(client: client)
        flightDates = FlightDates(client: client)
        flightOffers = FlightOffers(client: client)
        hotelOffers = HotelOffers(client: client)
        hotelOfferByHotel = HotelOfferByHotel(client: client)
        self.client = client
    }

    public func hotelOffer(hotelId: String) -> HotelOffer {
        return HotelOffer(client: client, hotelId: hotelId)
    }
}
