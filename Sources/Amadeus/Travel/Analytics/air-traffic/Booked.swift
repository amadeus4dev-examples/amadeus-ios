import Foundation

/// A namespaced client for the `v1/travel/analytics/air-traffic/booked` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.booked
/// ```
public class Booked {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Returns a list of air traffic reports based on the number of bookings.
    ///
    ///   ## Example
    ///   Find the air traffic from London in May 2016
    ///
    ///     amadeus.travel.analytics.airTraffic.booked.get(
    ///         params: [originCityCode:"LON",
    ///         period: "2016-05"],
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - originCityCode: `String` IATA code of the origin city.
    ///    - period: `String` period when consumers are travelling in `YYYY-MM` format
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/travel/analytics/air-traffic/booked", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
