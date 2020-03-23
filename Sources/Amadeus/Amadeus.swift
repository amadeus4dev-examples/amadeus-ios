import Foundation

public class Amadeus {
    public let client: Client
    public let shopping: Shopping
    public let travel: Travel
    public let referenceData: ReferenceData

    public init(client_id: String, client_secret: String, environment: [String: Any]) {
        client = Client(client_id: client_id,
                        client_secret: client_secret,
                        environment: environment)

        shopping = Shopping(client: client)
        travel = Travel(client: client)
        referenceData = ReferenceData(client: client)
    }

    public convenience init() {
        let client_id = ProcessInfo.processInfo.environment["AMADEUS_CLIENT_ID"] ?? ""
        let secret_id = ProcessInfo.processInfo.environment["AMADEUS_CLIENT_SECRET"] ?? ""

        self.init(client_id: client_id,
                  client_secret: secret_id,
                  environment: [:])
    }

    public convenience init(client_id: String, client_secret: String) {
        self.init(client_id: client_id,
                  client_secret: client_secret,
                  environment: [:])
    }

    public convenience init(environment: [String: Any]) {
        let client_id = ProcessInfo.processInfo.environment["AMADEUS_CLIENT_ID"] ?? ""
        let secret_id = ProcessInfo.processInfo.environment["AMADEUS_CLIENT_SECRET"] ?? ""

        self.init(client_id: client_id,
                  client_secret: secret_id,
                  environment: environment)
    }

    private func getComponentsFromURL(data: Response, keyword: String) -> (path: String, params: [String: String]) {
        if let nextURL = data.result["meta"]["links"][keyword].string {
            let url = URL(string: nextURL)

            var dict = [String: String]()
            let components = URLComponents(url: url!, resolvingAgainstBaseURL: false)!

            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value!
                }
            }
            return (components.path, dict)
        } else {
            return ("error", [:])
        }
    }

    public func next(data: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(data: data, keyword: "next")

        if path == "error" {
            onCompletion(nil, nil)
        }

        client.get(path: path, params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                        })
    }

    public func previous(data: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(data: data, keyword: "previous")

        if path == "error" {
            onCompletion(nil, nil)
        }

        client.get(path: path, params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                        })
    }

    public func last(data: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(data: data, keyword: "last")

        if path == "error" {
            onCompletion(nil, nil)
        }

        client.get(path: path, params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                        })
    }

    public func first(data: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(data: data, keyword: "last")

        if path == "error" {
            onCompletion(nil, nil)
        }

        client.get(path: path, params: params, onCompletion: {
            response, error in
            onCompletion(response, error)
                            })
    }
}
