import Foundation

/// A namespaced client for the `v2/media/files/generated-photos` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.media.files.generatedPhotos
/// ```
public class GeneratedPhotos {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    /// Get a link to download a rendered image of a landscape.
    ///
    /// - Returns:
    ///    `JSON` object
    public func get(params: [String: String], onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/media/files/generated-photos", params: params, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
