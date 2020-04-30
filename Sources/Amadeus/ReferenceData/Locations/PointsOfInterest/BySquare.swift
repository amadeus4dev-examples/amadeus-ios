import Foundation

/// A namespaced client for the `v1/reference-data/locations/pois/by-square` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.referenceData.locations.points.bySquare
/// ```
public class BySquare {
    private var client: Client

    public init(client: Client) {
        self.client = client
    }

    /// Returns a list of relevant points of interest
    /// around a defined square (4 points).
    ///
    ///   amadeus.referenceData.locations.pointsOfInterest.bySquare.get(
    ///                                            params: ["north": "41.397158",
    ///                                                   "west": "2.160873",
    ///                                                   "south": "41.394582",
    ///                                                   "east": "2.177181"],
    ///                                            onCompletion: {
    ///                                               (data,error) in ...}
    /// - Parameters:
    ///    - north: Latitude north of bounding box
    ///    - west:  Longitude west of bounding box
    ///    - south: Latitude south of bounding box
    ///    - east:  Longitude east of bounding box
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/reference-data/locations/pois/by-square", params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }

}
