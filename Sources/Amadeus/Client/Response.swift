import Foundation
import SwiftyJSON

public enum ResponseError: Error {
    case badRequestError(String) // 400 - the client did not provide the right parameters
    case authenticationError // 401 - the client did not provide the right credentials
    case forbiddenError // 403 - access an invalid enpoint
    case notFoundError // 404 - the path could not be found
    case tooManyRequestsError // 429 - too many requests
    case internalServerError // 500 - there is an error on the server
    case unknownStatusCode(Int) // unknown http code
    case returnedError(Error) // non http error
    case invalidInputJSON // invalid JSON in the request
}

public class Response {
    public var body: String
    public var result: JSON
    public var meta: JSON
    public var headers: JSON
    public var data: JSON
    public var statusCode: Int
    public var parsed: Bool

    public func getErrorCode() -> ResponseError? {
        switch statusCode {
        case 200 ... 208:
            return nil
        case 400:
            return ResponseError.badRequestError(result["errors"][0]["detail"].string ?? "Invalid format")
        case 401:
            return ResponseError.authenticationError
        case 403:
            return ResponseError.forbiddenError
        case 404:
            return ResponseError.notFoundError
        case 429:
            return ResponseError.tooManyRequestsError
        case 500:
            return ResponseError.internalServerError
        default:
            return ResponseError.unknownStatusCode(statusCode)
        }
    }

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
