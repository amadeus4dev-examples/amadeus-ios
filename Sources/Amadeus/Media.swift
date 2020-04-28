import Foundation

/// A namespaced client for the `v1/media` endpoints
///
/// Access via the `Amadeus` object
/// ```swift
/// let amadeus = Amadeus(client_id, secret_id)
/// amadeus.media
/// ```
public class Media {
    public let files: Files

    public init(client: Client) {
        files = Files(client: client)
    }
}
