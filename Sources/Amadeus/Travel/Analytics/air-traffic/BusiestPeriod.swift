import Foundation

/// A namespaced client for the `v1/travel/analytics/air-traffic/busiest-period` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic.busiestPeriod
/// ```
public class BusiestPeriod {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Returns a list of air traffic reports.
    ///
    ///   ## Example
    ///   Find the air traffic for travelers arriving in Paris in 2017
    ///
    ///     amadeus.travel.analytics.airTraffic.busiestPeriod.get(
    ///         params: ["cityCode":"PAR",
    ///         "period": "2017",
    ///         "direction": "arriving"],
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - cityCode: `String` IATA code of the origin city.
    ///    - period: `String` period when consumers are travelling in `YYYY` format
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/travel/analytics/air-traffic/busiest-period", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
