import Foundation

/// A namespaced client for the `v1/reference-data/locations/pois` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations.pointsOfInterest
/// ```
public class PointOfInterest {
    private let client: Client
    private let poiId: String

    public init(client: Client, poiId: String) {
        self.client = client
        self.poiId = poiId
    }

    /// Retrieve one point of interest by its Id.
    ///
    ///   amadeus.referenceData.locations.pointOfInterest("9CB40CB5D0").get(
    ///         onCompletion: {
    ///             (data,error) in ... })
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/reference-data/locations/pois/\(poiId)", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
