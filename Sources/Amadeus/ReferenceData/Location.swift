import Foundation

/// A namespaced client for the `v2/reference-data/locations` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations
/// ```
public class Location {
    private let client: Client
    private let locationId: String

    public init(client: Client, locationId: String) {
        self.client = client
        self.locationId = locationId
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
    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/reference-data/locations/\(locationId)", params: data, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
