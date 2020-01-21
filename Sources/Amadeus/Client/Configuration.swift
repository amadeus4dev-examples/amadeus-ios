import Foundation

public class Configuration{
    
    public var logLevel = "silent"
    public var hostname = "test"
    public var host = "test.api.amadeus.com"
    public var ssl = true
    public var port = 443
    public var customAppId = ""
    public var customAppVersion = ""
    
    public init(enviroment:[String:Any]){
        setHostname(enviroment: enviroment)
        setHost(enviroment: enviroment)
        setLogLevel(enviroment: enviroment)
        setSsl(enviroment: enviroment)
        setPort(enviroment: enviroment)
        setCustomAppId(enviroment: enviroment)
        setCustomAppVersion(enviroment: enviroment)
    }
    
    private func setHostname(enviroment:[String:Any]){
        if let hostname = enviroment["hostName",default: hostname] as? String{
            self.hostname = hostname
        }
    }
    private func setHost(enviroment:[String:Any]){
        if let host = enviroment["host",default: host] as? String{
            self.host = host
        }
    }
    private func setLogLevel(enviroment:[String:Any]){
        if let logLevel = enviroment["logLevel",default: logLevel] as? String{
            self.logLevel = logLevel
        }
    }
    private func setSsl(enviroment:[String:Any]){
        if let ssl = enviroment["ssl",default: ssl] as? Bool{
            self.ssl = ssl
        }
    }
    private func setPort(enviroment:[String:Any]){
        if let port = enviroment["port",default: port] as? Int{
            self.port = port
        }
    }
    private func setCustomAppId(enviroment:[String:Any]){
        if let customAppId = enviroment["customAppId",default: customAppId] as? String{
            self.customAppId = customAppId
        }
    }
    private func setCustomAppVersion(enviroment:[String:Any]){
        if let customAppVersion = enviroment["customAppVersion",default: customAppVersion] as? String{
            self.customAppVersion = customAppVersion
        }
    }
    
}
