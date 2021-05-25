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
    public let seatMaps: SeatMaps
    public let hotelOffers: HotelOffers
    public let hotelOfferByHotel: HotelOfferByHotel
    public let activities: Activities
    public let availability: Availability

    private let client: Client

    public init(client: Client) {
        flightOffersSearch = FlightOffersSearch(client: client)
        flightDestinations = FlightDestinations(client: client)
        flightDates = FlightDates(client: client)
        flightOffers = FlightOffers(client: client)
        seatMaps = SeatMaps(client: client)
        hotelOffers = HotelOffers(client: client)
        hotelOfferByHotel = HotelOfferByHotel(client: client)
        activities = Activities(client: client)
        self.availability = Availability(client: client)
        self.client = client
    }

    public func hotelOffer(hotelId: String) -> HotelOffer {
        return HotelOffer(client: client, hotelId: hotelId)
    }

    public func activity(activityId: String) -> Activity {
        return Activity(client: client, activityId: activityId)
    }
 
}
