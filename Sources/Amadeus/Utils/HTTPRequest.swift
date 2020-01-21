import Foundation
import SwiftyJSON

public typealias ServiceResponse = (JSON, NSError?) -> Void
public typealias AmadeusResponse = (Response?, Error?) -> Void

public func makeHTTPGetRequestAuth(_ path: String, auth: String, body: String, client:Client, onCompletion: @escaping ServiceResponse) {
    var url:String = ""
    
    if client.configuration.ssl {
        url += "https://"
    }else{
        url += "http://"
    }
    url += client.configuration.host + path + body
    print("URL GET:", url)

    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        
        do{
            if let jsonData = data {
                let json:JSON = try JSON(data: jsonData)
                onCompletion(json, nil)
            } else {
                onCompletion(JSON.null, error as NSError?)
            }
        }catch let err as NSError{
            print("error:",err)
        }
        
    })
    task.resume()
}

public func makeHTTPPostRequest(_ path: String, body: String, ssl:Bool, host:String, onCompletion: @escaping ServiceResponse) {
    var url:String = ""
    
    if ssl {
        url += "https://"
    }else{
        url += "http://"
    }
    url += host + "/" + path
    print("URL POST:", url)

    let request = NSMutableURLRequest(url: URL(string: url)!)

    request.httpMethod = "POST"
    request.httpBody = body.data(using: String.Encoding.utf8);
    
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    print(request)
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        
        do{
            if let jsonData = data {
                let json:JSON = try JSON(data: jsonData)
                print(json)
                onCompletion(json, nil)
            } else {
                onCompletion(JSON.null, error as NSError?)
            }
        }catch let err as NSError{
            print("error:",err)
        }
        
    })
    task.resume()
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

public func generateURL(client:Client, path:String, data:[String:String]) -> String{
    var url = "http://"
    if client.configuration.ssl {
        url += "https://"
    }
    
    url += client.configuration.host + "/" + path
    
    url += generateGetParameters(data: data)
    return url
}

public func getRequest(path: String, auth: String, client:Client, onCompletion: @escaping AmadeusResponse) {
    
    let url = path
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    
    if client.configuration.customAppId != ""{
        request.addValue(client.configuration.customAppId, forHTTPHeaderField: "User-Agent")
    }
    
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        let amadeusResponse:Response?
        let amadeusError: Error?
        if let httpResponse = response as? HTTPURLResponse {
            amadeusResponse = Response(response: httpResponse, data:data!)
            amadeusError = nil
            
        }else{
            amadeusResponse = nil
            amadeusError = error
        }
        
        onCompletion(amadeusResponse,amadeusError)
    })
    task.resume()
}
