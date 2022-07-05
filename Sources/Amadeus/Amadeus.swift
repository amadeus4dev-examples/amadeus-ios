import Foundation

public class Amadeus {
    public let client: Client
    public let shopping: Shopping
    public let booking: Booking
    public let airport: Airport
    public let travel: Travel
    public let eReputation: EReputation
    public let referenceData: ReferenceData
    public let safety: Safety
    public let schedule: Schedule
    public let analytics: Analytics
    public let location: Location
    
    public init(client_id: String, client_secret: String, environment: [String: Any]) {
        client = Client(client_id: client_id,
                        client_secret: client_secret,
                        environment: environment)
        
        shopping = Shopping(client: client)
        booking = Booking(client: client)
        airport = Airport(client: client)
        travel = Travel(client: client)
        eReputation = EReputation(client: client)
        referenceData = ReferenceData(client: client)
        safety = Safety(client: client)
        schedule = Schedule(client: client)
        analytics = Analytics(client: client)
        location = Location(client: client)
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
    
    private func getComponentsFromURL(response: Response, keyword: String) -> (path: String, params: [String: String]) {
        if let nextURL = response.result["meta"]["links"][keyword].string {
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
    
    public func next(response: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(response: response, keyword: "next")
        
        guard path != "error" else { onCompletion(.failure(.badRequestError("Error"))); return }
        
        client.get(path: path, params: params, onCompletion: { result in
            onCompletion(result)
        })
    }
    
    public func previous(response: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(response: response, keyword: "previous")
        
        guard path != "error" else { onCompletion(.failure(.badRequestError("Error"))); return }
        
        client.get(path: path, params: params, onCompletion: { result in
            onCompletion(result)
        })
    }
    
    public func last(response: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(response: response, keyword: "last")
        
        guard path != "error" else { onCompletion(.failure(.badRequestError("Error"))); return }
        
        client.get(path: path, params: params, onCompletion: { result in
            onCompletion(result)
        })
    }
    
    public func first(response: Response, onCompletion: @escaping AmadeusResponse) {
        let (path, params) = getComponentsFromURL(response: response, keyword: "last")
        
        guard path != "error" else { onCompletion(.failure(.badRequestError("Error"))); return }
        
        client.get(path: path, params: params, onCompletion: { result in
            onCompletion(result)
        })
    }
}
