import Foundation

/// A namespaced client for the `v2/reference-data/locations` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations
/// ```
public class Locations {
    private let client: Client

    public let airports: Airports
    public let pointsOfInterest: PointsOfInterest

    public init(client: Client) {
        self.client = client
        airports = Airports(client: client)
        pointsOfInterest = PointsOfInterest(client: client)
    }

    public func pointOfInterest(poiId: String) -> PointOfInterest {
        return PointOfInterest(client: client, poiId: poiId)
    }

    /// Returns a list of airports and cities matching a given keyword.
    ///
    ///   ## Example
    ///   Find any location starting with 'lon'
    ///
    ///     amadeus.referenceData.locations.get(
    ///         subType:"AIRPORT,CITY",
    ///         keyword:"lon",
    ///         onCompletion: {
    ///             data in ...}
    ///     )
    /// - Parameters:
    ///    - subType: `String` Type of location to search for
    ///    - keyword: `String` That should represent the start of a word in a city or airport name or code.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/reference-data/locations", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
