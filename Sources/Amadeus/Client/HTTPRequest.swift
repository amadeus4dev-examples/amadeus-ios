import Foundation
import SwiftyJSON

public typealias AmadeusResponse = (Response?, Error?) -> Void

public func _get(url: String,
                headers: [String:String],
                onCompletion: @escaping AmadeusResponse) {

    let request = NSMutableURLRequest(url: URL(string: url)!)

    for header in headers {
        request.setValue(header.value, forHTTPHeaderField: header.key)
    }

    send(request:request, onCompletion: {
             (response, error) in
             onCompletion(response, error)
         })
}

public func _post(url: String,
                 headers: [String:String],
                 body: String,
                 onCompletion: @escaping AmadeusResponse) {
                                           
    let request = NSMutableURLRequest(url: URL(string: url)!)
    
    request.httpMethod = "POST"
    request.httpBody = body.data(using: String.Encoding.utf8);
 
    for header in headers {
        request.setValue(header.value, forHTTPHeaderField: header.key)
    }

    send(request:request, onCompletion: { (response, error) -> Void in
             onCompletion(response, error)
         })
}

private func send(request:NSMutableURLRequest,
                  onCompletion: @escaping AmadeusResponse) {

    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

       let amadeusResponse:Response?
       let amadeusError: Error?

       if let httpResponse = response as? HTTPURLResponse {
            amadeusResponse = Response(response: httpResponse, data:data!)
            amadeusError = nil
            
        } else {
            amadeusResponse = nil
            amadeusError = error
        }

        onCompletion(amadeusResponse, amadeusError)
    })
    task.resume()
}
