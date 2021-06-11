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
    private var locationId: String?
    // Since we cannot have two 'Location' classes under the
    // same module, we need to instantiate analytics here even
    // if it belongs to the endpoint location/analytics/
    public var analytics: Analytics!
    
    public init(client: Client, locationId: String) {
        self.client = client
        self.locationId = locationId
    }
    
    public init(client: Client) {
        self.client = client
        analytics = Analytics (client: client)
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
        client.get(path: "v1/reference-data/locations/\(locationId)", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
