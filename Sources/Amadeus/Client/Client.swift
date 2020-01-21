import Foundation
import SwiftyJSON


/// A memorized Access Token, with the ability to auto-refresh when needed.

public class Client {
    fileprivate let urlAuth = "v1/security/oauth2/token"
    private let grant_type: String
    public var client_id: String
    public var client_secret:String
    
    public var configuration:Configuration
    
    private var access_token: String
    private var expires_time: Int
    
    
    public init(client_id: String, client_secret:String, enviroment:[String:Any]) {
        self.grant_type =  "client_credentials"
        self.client_id = client_id
        self.client_secret = client_secret
        self.configuration = Configuration(enviroment: enviroment)
        self.expires_time = 0
        self.access_token = ""
    }
    
    ///This method checks if the access_tocken needs to be renewed and, if needed, request the access_token,
    ///updates the token and save it, if you do not have to renew it returns the access_token that we had stored
    ///
    /// - Returns:
    ///     access_token: `String` the client access token
    public func getAccessToken(onCompletion: @escaping (String) -> Void){
        if needRefresh() {
            getAuthToken(onCompletion: {
                access_token in
                
                onCompletion(access_token)
            })
            
        }else{
            onCompletion(access_token)
        }
    }
    

    ///Checks if this access token needs a refresh.
    private func needRefresh() -> Bool{
        return (access_token == "" || access_token == "error" || Int(Date().timeIntervalSince1970 * 1000) > expires_time)
    }

    ///Fetches a new Access Token using the credentials from the client.
    private func getAuthToken(onCompletion: @escaping (String) -> Void){
        let body = "grant_type=" + grant_type + "&client_id=" + client_id + "&client_secret=" + client_secret
        makeHTTPPostRequest(urlAuth, body: body, ssl:configuration.ssl, host:configuration.host, onCompletion: { (data, err) in
            if let error = data["error"].string{
                onCompletion(error)
            }else{
                if let auth = data["access_token"].string{
                    onCompletion(auth)
                }else{
                    onCompletion("error")
                }
            }
            self.storeData(data: data)
        })
    }

    ///Store the fetched access token and expiry date.
    private func storeData(data: JSON){
        if let access_token = data["access_token"].string{
            self.access_token = access_token
        }else{
            self.access_token = "error"
        }
        
        if let expires_time = data["expires_in"].int{
            self.expires_time = expires_time * 1000 + Int(Date().timeIntervalSince1970 * 1000)
        }else{
            self.expires_time = 0
        }
    }
    
}
