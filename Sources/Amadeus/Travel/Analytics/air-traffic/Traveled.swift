import Foundation

/// A namespaced client for the `v1/travel/analytics/air-traffic/traveled` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.traveled
/// ```
public class Traveled {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Returns a list of air traffic reports based on the number of people traveling.
    ///
    ///   ## Example
    ///   Find the air traffic from Nice in August 2017
    ///
    ///     amadeus.travel.analytics.airTraffic.booked.get(
    ///         originCityCode:"NCE",
    ///         period: "2017-08",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - originCityCode: `String` IATA code of the origin city.
    ///    - period: `String` period when consumers are travelling in `YYYY-MM` format
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/travel/analytics/air-traffic/traveled", params: data, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
