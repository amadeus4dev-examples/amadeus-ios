import Foundation
import SwiftyJSON

public class Response{
    
    public var body:String
    public var result:JSON
    public var meta:JSON
    public var headers:JSON
    public var data:JSON
    public var statusCode:Int
    public var parsed:Bool
    
    public init(response:HTTPURLResponse, data:Data?) {

        // statusCode: The HTTP status code for the response, if any
        self.statusCode = response.statusCode

        //body: the raw body received from the API
        self.body = String(data: data!, encoding: .utf8) ?? ""

        // HEADERS
        if response.allHeaderFields.count > 0 {
            self.headers = JSON.init(response.allHeaderFields)
        }else{
            self.headers = JSON.null
        }
        
        // result: the parsed JSON received from the API, if the result was JSON
        do{
            self.parsed = false
            if let jsonData = data {
                let json:JSON = try JSON(data: jsonData)
                self.result = json
                // parsed: wether the raw body has been parsed into JSON
                self.parsed = true
                
                // meta: the meta extracted from the JSON data
                self.meta = self.result["meta"]
                
                // data: the data extracted from the JSON data
                self.data = self.result["data"]
            } else {
                self.result = JSON.null
                self.meta = JSON.null
                self.data = JSON.null
            }
        } catch _ as NSError{
            self.result = JSON.null
            self.meta = JSON.null
            self.data = JSON.null
        }
    }
    
}
