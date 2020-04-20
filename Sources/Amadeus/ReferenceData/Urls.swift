import Foundation

/// A namespaced client for the `v2/reference-data/urls` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.urls
/// ```
public class Urls {
    public let checkinLinks: CheckinLinks

    public init(client: Client) {
        checkinLinks = CheckinLinks(client: client)
    }
}
