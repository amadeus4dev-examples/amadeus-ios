import Foundation

/// A namespaced client for the `v1/media/files` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.media.files
/// ```
public class Files {
    public let generatedPhotos: GeneratedPhotos

    public init(client: Client) {
        generatedPhotos = GeneratedPhotos(client: client)
    }
}
