import Foundation
import SwiftyJSON

public class TripParserJobs {
    private var client: Client
    
    public init(client: Client) {
        self.client = client
    }
    
    public func status(jobId: String) -> TripParserStatus {
        return TripParserStatus(client: client, jobId: jobId)
    }
    
    public func result(jobId: String) -> TripParserResult {
        return TripParserResult(client: client, jobId: jobId)
    }
    
    /// Sends the request for the parsing with the
    /// booking details and input parameters.
    public func post(body: JSON, onCompletion: @escaping AmadeusResponse) {
        client.post(path: "/v2/travel/trip-parser-jobs", body: body, onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
