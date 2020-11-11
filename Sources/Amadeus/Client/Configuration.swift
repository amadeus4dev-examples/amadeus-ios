import Foundation

public class Configuration {
    public var logLevel = "silent"
    public var host = "test.api.amadeus.com"
    public var ssl = true
    public var port = 443
    public var customAppId = "amadeus-swift-sdk"
    public var customAppVersion = "1.3.0"
    public var baseURL = ""

    public init(environment: [String: Any]) {
        setHost(environment: environment)
        setLogLevel(environment: environment)
        setSsl(environment: environment)
        setPort(environment: environment)
        setCustomAppId(environment: environment)
        setCustomAppVersion(environment: environment)
        setBaseURL()
    }

    private func setBaseURL() {
        var prot = "http://"

        if ssl {
            prot = "https://"
        }

        baseURL = prot + host + "/"
    }

    private func setHost(environment: [String: Any]) {
        if let host = environment["host", default: host] as? String {
            self.host = host
        }
    }

    private func setLogLevel(environment: [String: Any]) {
        if let logLevel = environment["logLevel", default: logLevel] as? String {
            self.logLevel = logLevel
        }
    }

    private func setSsl(environment: [String: Any]) {
        if let ssl = environment["ssl", default: ssl] as? Bool {
            self.ssl = ssl
        }
    }

    private func setPort(environment: [String: Any]) {
        if let port = environment["port", default: port] as? Int {
            self.port = port
        }
    }

    private func setCustomAppId(environment: [String: Any]) {
        if let customAppId = environment["customAppId", default: customAppId] as? String {
            self.customAppId = customAppId
        }
    }

    private func setCustomAppVersion(environment: [String: Any]) {
        if let customAppVersion = environment["customAppVersion", default: customAppVersion] as? String {
            self.customAppVersion = customAppVersion
        }
    }
}
