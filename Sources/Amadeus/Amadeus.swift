import Foundation

/// A namespaced amadeus
public class Amadeus {
    
    public let client:Client
    public let shopping:Shopping
    public let travel:Travel
    public let referenceData:ReferenceData
    
    
    
    public init(client_id: String, client_secret:String, enviroment:[String:Any]) {
        client = Client(client_id: client_id, client_secret: client_secret, enviroment: enviroment)
        shopping = Shopping(client: client)
        travel = Travel(client: client)
        referenceData = ReferenceData(client: client)
    }
    
    public convenience init(){
        self.init(client_id: "", client_secret: "", enviroment: [:])
    }
    
    public convenience init(client_id: String, client_secret:String){
        self.init(client_id:client_id, client_secret:client_secret,enviroment: [:])
    }
    
    private func getUrl(data:Response, keyword:String) -> String{
        return data.body["meta"]["links"][keyword].string ?? "error"
        
    }
    
    public func next(data: Response, onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.getUrl(data: data, keyword: "next")
                if path != "error"{
                    getRequest(path: path, auth: auth, client: self.client, onCompletion: {
                        data,err  in
                        if let error = err {
                            onCompletion(nil,error)
                        }else{
                            onCompletion(data,nil)
                        }
                    })
                }else{
                    onCompletion(nil,nil)
                }
            }else{
                onCompletion(nil,nil)
            }
        })
    }
    
    public func previous(data: Response, onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.getUrl(data: data, keyword: "previous")
                if path != "error"{
                    getRequest(path: path, auth: auth, client: self.client, onCompletion: {
                        data,err  in
                        if let error = err {
                            onCompletion(nil,error)
                        }else{
                            onCompletion(data,nil)
                        }
                    })
                }else{
                    onCompletion(nil,nil)
                }
            }else{
                onCompletion(nil,nil)
            }
        })
    }
    
    public func last(data: Response, onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.getUrl(data: data, keyword: "last")
                if path != "error"{
                    getRequest(path: path, auth: auth, client: self.client, onCompletion: {
                        data,err  in
                        if let error = err {
                            onCompletion(nil,error)
                        }else{
                            onCompletion(data,nil)
                        }
                    })
                }else{
                    onCompletion(nil,nil)
                }
            }else{
                onCompletion(nil,nil)
            }
        })
    }
    public func first(data: Response, onCompletion: @escaping AmadeusResponse){
        client.getAccessToken(onCompletion: {
            (auth) in
            if auth != "error" {
                let path = self.getUrl(data: data, keyword: "first")
                if path != "error"{
                    getRequest(path: path, auth: auth, client: self.client, onCompletion: {
                        data,err  in
                        if let error = err {
                            onCompletion(nil,error)
                        }else{
                            onCompletion(data,nil)
                        }
                    })
                }else{
                    onCompletion(nil,nil)
                }
            }else{
                onCompletion(nil,nil)
            }
        })
    }
}
