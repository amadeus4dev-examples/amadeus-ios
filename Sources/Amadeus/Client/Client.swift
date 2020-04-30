import Foundation
import SwiftyJSON

enum ClientError: Error {
    case AuthenticationError
}

public class Client {
    public let accessToken: AccessToken
    public let configuration: Configuration

    public init(client_id: String, client_secret: String, environment: [String: Any]) {
        configuration = Configuration(environment: environment)

        accessToken = AccessToken(client_id: client_id,
                                  client_secret: client_secret,
                                  config: configuration)
    }

    private func generateGetParameters(params: [String: String]) -> String {
        var res = ""
        var firstTime = true
        for item in params {
            if firstTime {
                firstTime = false
                res += "?\(item.key)=\(item.value)"
            } else {
                res += "&\(item.key)=\(item.value)"
            }
        }
        return res
    }

    public func get(path: String, params: [String: String], onCompletion: @escaping AmadeusResponse) {
        request(verb: "GET", path: path, params: generateGetParameters(params: params), body: nil, onCompletion: {
            response, error in
            onCompletion(response, error)
        })
    }

    public func post(path: String, body: JSON, params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        if let bodyString = body.rawString() {
            request(verb: "POST", path: path, params: generateGetParameters(params: params), body: bodyString, onCompletion: {
                response, error in
                onCompletion(response, error)
            })
        } else {
            onCompletion(nil, ResponseError.invalidInputJSON)
        }
    }

    public func delete(path: String, params: [String: String] = [:], onCompletion: @escaping AmadeusResponse) {
        request(verb: "DELETE", path: path, params: generateGetParameters(params: params), body: nil, onCompletion: {
            response, error in
            onCompletion(response, error)
        })
    }

    private func prettyPrintRequest(verb: String, url: String, headers: [String: String]) {
        print("\n")
        print("\(verb) \(url)")
        for header in headers {
            print("\(header.key): \(header.value)")
        }
        print("\n")
    }

    private func request(verb: String, path: String, params: String, body: String?, onCompletion: @escaping AmadeusResponse) {

        accessToken.get(onCompletion: { auth, error in
            let err: ResponseError? = error

            if err == nil {
                let url = self.configuration.baseURL + path + params

                let headers = ["Content-Type": "application/json",
                               "Authorization": "Bearer \(auth!)",
                               "User-Agent": "\(self.configuration.customAppId)/\(self.configuration.customAppVersion)"]

                if self.configuration.logLevel == "debug" {
                    self.prettyPrintRequest(verb: verb, url: url, headers: headers)
                }

                send(verb: verb,
                        url: url,
                        headers: headers,
                        body: body,
                        onCompletion: {
                            data, err in
                            onCompletion(data, err)
                        })
            } else {
                onCompletion(nil, error)
            }
        })
    }
}
