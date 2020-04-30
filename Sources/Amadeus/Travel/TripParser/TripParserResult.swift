import Foundation

public class TripParserResult {
    private let client: Client
    private let jobId: String

    public init(client: Client, jobId: String) {
        self.client = client
        self.jobId = jobId
    }

    /// Returns the complete result of parsing as an aggregated view of Trip
   public func get(onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v2/travel/trip-parser-jobs/\(jobId)/result", params: [:], onCompletion: {
            response, error in
            onCompletion(response, error)
                    })
    }
}
