import Foundation

public class Client {
    
    public let accessToken:AccessToken
    public let configuration:Configuration

    public init(client_id: String, client_secret:String, environment:[String:Any]) {
        configuration = Configuration(environment: environment)
        
        accessToken = AccessToken(client_id: client_id,
                                  client_secret: client_secret,
                                  config: configuration)
    }

    private func generateGetParameters(data: [String:String]) -> String{
        var res = ""
        var firstTime = true
        for item in data {
            if firstTime {
                firstTime = false
                res += "?\(item.key)=\(item.value)"
            }else{
                res += "&\(item.key)=\(item.value)"
            }
        }
        return res
    }

    public func get(path: String, params: [String:String], onCompletion: @escaping AmadeusResponse){
        self.request(verb: "GET", path: path, params: generateGetParameters(data:params), onCompletion: {
            (response, error) in 
            onCompletion(response, error) 
        })
    }

    public func post(path: String, body: String, onCompletion: @escaping AmadeusResponse) {
        self.request(verb: "POST", path: path, params: body, onCompletion: {
            (response, error) in 
            onCompletion(response, error) 
        })
    }

    private func request(verb: String, path: String, params: String, onCompletion: @escaping AmadeusResponse) {
        self.accessToken.get(onCompletion: {
            (auth) in
            if auth != "error" {

                let url = self.configuration.baseURL + path + params

                let headers = ["Content-Type"  : "application/json",
                               "Authorization" : "Bearer \(auth)"]
 
                if verb == "GET" {
                    _get(url:url, headers:headers, onCompletion: {
                        (data,err)  in
                            if let error = err {
                                onCompletion(nil,error)
                            }else{
                                onCompletion(data,nil)
                            }
                        })
                }

                if verb == "POST" {
                    _post(url:url, headers:headers, body: params, onCompletion: {
                        (data,err)  in
                            if let error = err {
                                onCompletion(nil,error)
                            }else{
                                onCompletion(data,nil)
                            }
                        })
                }

            }else{
                onCompletion(nil,nil)
            }
        })
    }
}
