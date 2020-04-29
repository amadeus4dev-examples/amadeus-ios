import Foundation

/// A namespaced client for the `v1/reference-data/locations/pois` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations.pointsOfInterest
/// ```
public class PointsOfInterest {
    private let client: Client
    public var bySquare: BySquare

    public init(client: Client) {
        self.client = client
        bySquare = BySquare(client: client)
    }

    /// Returns a list of relevant points of interest near to a given point.
    ///
    ///   ## Example
    ///   Find relevant points of interest close to Barcelona
    ///
    ///   amadeus.referenceData.locations.pointsOfInterest.get(
    ///         data["longitude": "2.160873",
    ///              "latitude":  "41.397158",
    ///         onCompletion: {
    ///             (data,error) in ...}
    ///     )
    ///
    /// - Parameters:
    ///    - longitude: longitude location to be at the center of the search circle
    ///    - latitude:  latitude location to be at the center of the search circle
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(data: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/reference-data/locations/pois", params: data, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
