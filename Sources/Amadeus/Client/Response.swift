import Foundation
import SwiftyJSON

public class Response {
    public var body: String
    public var result: JSON
    public var meta: JSON
    public var headers: JSON
    public var data: JSON
    public var statusCode: Int
    public var parsed: Bool

    public init(response: HTTPURLResponse, data: Data?) {
        // statusCode: The HTTP status code for the response, if any
        statusCode = response.statusCode

        // body: the raw body received from the API
        body = String(data: data!, encoding: .utf8) ?? ""

        // headers
        if response.allHeaderFields.count > 0 {
            headers = JSON(response.allHeaderFields)
        } else {
            headers = JSON.null
        }

        // result: the parsed JSON received from the API, if the result was JSON
        do {
            parsed = false
            if let jsonData = data {
                let json: JSON = try JSON(data: jsonData)
                result = json
                // parsed: wether the raw body has been parsed into JSON
                parsed = true

                // meta: the meta extracted from the JSON data
                meta = result["meta"]

                // data: the data extracted from the JSON data
                self.data = result["data"]
            } else {
                result = JSON.null
                meta = JSON.null
                self.data = JSON.null
            }
        } catch _ as NSError {
            result = JSON.null
            meta = JSON.null
            self.data = JSON.null
        }
    }
}
