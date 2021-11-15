import Foundation

public class Configuration {
    public var logLevel = "silent"
    public var hostname = "test.api.amadeus.com"
    public var ssl = true
    public var port = 443
    public var customAppId = "amadeus-swift-sdk"
    public var customAppVersion = "2.0.0"
    public var baseURL = ""

    public init(environment: [String: Any]) {
        setHostname(environment: environment)
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

        baseURL = prot + hostname + "/"
    }

    private func setHostname(environment: [String: Any]) {
        if let host = environment["hostname", default: hostname] as? String {
            if host == "production" {
                self.hostname = "api.amadeus.com"
            } else if host == "testing" {
                self.hostname = "test.api.amadeus.com"
            } else {
                self.hostname = host
            }
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
