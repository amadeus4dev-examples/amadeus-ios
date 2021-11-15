@testable import Amadeus
import XCTest

class CoreTests: XCTestCase {
    var client: Amadeus!

    override func setUp() {
        super.setUp()
        client = Amadeus()
    }

    func testConfiguration() {
        let conf = Configuration(environment: [:])
        XCTAssertEqual(conf.logLevel, "silent")
        XCTAssertEqual(conf.hostname, "test.api.amadeus.com")
        XCTAssertTrue(conf.ssl)
        XCTAssertEqual(conf.port, 443)
        XCTAssertEqual(conf.customAppId, "amadeus-swift-sdk")
        XCTAssertEqual(conf.customAppVersion, "2.0.0")
    }

    func testBuildCustomLogger() {
        let conf = Configuration(environment: ["logLevel": "debug"])
        XCTAssertEqual(conf.logLevel, "debug")
    }

    func testBuildCustomHostname() {
        let conf = Configuration(environment: ["hostname": "mymock.server.com"])
        XCTAssertEqual(conf.hostname, "mymock.server.com")
    }

    func testBuildProductionHostname() {
        let conf = Configuration(environment: ["hostname": "production"])
        XCTAssertEqual(conf.hostname, "api.amadeus.com")
    }
    
    func testBuildTestingHostname() {
        let conf = Configuration(environment: ["hostname": "testing"])
        XCTAssertEqual(conf.hostname, "test.api.amadeus.com")
    }
    
    func testBuildTestingDefaultHostname() {
        let conf = Configuration(environment: [:])
        XCTAssertEqual(conf.hostname, "test.api.amadeus.com")
    }
    
    func testBuildCustomHost() {
        let conf = Configuration(environment: ["hostname": "foo.bar.com"])
        XCTAssertEqual(conf.hostname, "foo.bar.com")
    }

    func testBuildCustomSsl() {
        let conf = Configuration(environment: ["ssl": true])
        XCTAssertTrue(conf.ssl)
        XCTAssertEqual(conf.port, 443)
    }

    func testBuildCustomSslWithCustomPort() {
        let conf = Configuration(environment: ["port": 8080, "ssl": true])
        XCTAssertTrue(conf.ssl)
        XCTAssertEqual(conf.port, 8080)
    }

    func testBuildCustomNonSsl() {
        let conf = Configuration(environment: ["ssl": false])
        XCTAssertFalse(conf.ssl)
    }

    func testBuildCustomNonSslWithCustomPort() {
        let conf = Configuration(environment: ["port": 8080, "ssl": false])
        XCTAssertFalse(conf.ssl)
        XCTAssertEqual(conf.port, 8080)
    }
}
