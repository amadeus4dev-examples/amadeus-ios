import Foundation

/// A namespaced client for the `v2/reference-data/` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.referenceData
/// ```
public class ReferenceData {
    public let airLines: AirLines
    public let urls: Urls
    public let locations: Locations
    private let client: Client

    public init(client: Client) {
        self.client = client
        airLines = AirLines(client: client)
        urls = Urls(client: client)
        locations = Locations(client: client)
    }

    public func location(locationId: String) -> Location {
        return Location(client: client, locationId: locationId)
    }
}
