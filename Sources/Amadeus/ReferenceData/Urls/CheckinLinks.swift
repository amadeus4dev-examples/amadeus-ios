import Foundation

/// A namespaced client for the `v2/reference-data/urls/checkin-links` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.urls.checkinLinks
/// ```
public class CheckinLinks {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Returns the checkin links for an airline.
    ///
    ///   ## Example
    ///   Find a the checkin links for Air France
    ///
    ///     amadeus.referenceData.urls.checkinLinks.get(
    ///         airlineCode:"AF",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - airlineCode: `String` Airline ID.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/reference-data/urls/checkin-links", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
