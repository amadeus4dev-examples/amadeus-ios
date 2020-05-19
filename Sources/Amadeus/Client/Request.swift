import Foundation

public typealias AmadeusResponse = (Result<Response, ResponseError>) -> Void

public func send(verb: String,
                 url: String,
                 headers: [String: String],
                 body: String?,
                 onCompletion: @escaping AmadeusResponse) {
    
    if let url = URL(string: url) {
        let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = verb
        
        if body != nil {
            request.httpBody = body!.data(using: String.Encoding.utf8)
        }
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        process(request: request, onCompletion: { result -> Void in
            onCompletion(result)
        })
    } else {
        onCompletion(.failure(.malformedURL))
    }
}

private func process(request: NSMutableURLRequest,
                     onCompletion: @escaping AmadeusResponse) {
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard let httpResponse = response as? HTTPURLResponse else {
            // no HTTP answer: network problem
            onCompletion(.failure(.returnedError(error!)))
            return
        }
        
        let response = Response(response: httpResponse, data: data!)
        
        // Error could be either nil (200 OK) or enum value
        if let error = response.getErrorCode() {
            onCompletion(.failure(error))
        } else {
            // got a valid HTTP answer
            onCompletion(.success(response))
        }
        
    })
    task.resume()
}
