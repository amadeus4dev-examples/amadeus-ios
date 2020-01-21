import XCTest
import Amadeus

class AmadeusTests: XCTestCase {
    
    func testGenerateURL() {
        let ama = Amadeus();
        XCTAssertEqual( generateURL(client: ama.client, path: "path", data: ["test":"test"]), "https://test.api.amadeus.com/path?test=test", "Prueba")
    }
    
    func testConfiguration() {
        let conf = Configuration(enviroment: [:])
        XCTAssertEqual(conf.logLevel, "silent")
        XCTAssertEqual(conf.hostname, "test")
        XCTAssertEqual(conf.host, "test.api.amadeus.com")
        XCTAssertTrue(conf.ssl)
        XCTAssertEqual(conf.port, 443)
        XCTAssertEqual(conf.customAppId, "")
        XCTAssertEqual(conf.customAppVersion, "")
    }
    
    func testBuildCustomLogger() {
        let conf = Configuration(enviroment: ["logLevel":"debug"])
         XCTAssertEqual(conf.logLevel, "debug")
    }
    func testBuildCustomHostname() {
        let conf = Configuration(enviroment: ["hostName":"production"])
        XCTAssertEqual(conf.hostname, "production")
        XCTAssertEqual(conf.host, "test.api.amadeus.com")
    }
    func testBuildCustomHost() {
        let conf = Configuration(enviroment: ["host":"foo.bar.com"])
        XCTAssertEqual(conf.host, "foo.bar.com")
    }
    func testBuildCustomSsl() {
        let conf = Configuration(enviroment: ["ssl":true])
        XCTAssertTrue(conf.ssl)
        XCTAssertEqual(conf.port, 443)
    }
    
    func testBuildCustomSslWithCustomPort() {
        let conf = Configuration(enviroment: ["port":8080,"ssl":true])
        XCTAssertTrue(conf.ssl)
        XCTAssertEqual(conf.port, 8080)
    }
    
    func testBuildCustomNonSsl() {
        let conf = Configuration(enviroment: ["ssl":false])
        XCTAssertFalse(conf.ssl)
    }
    
    func testBuildCustomNonSslWithCustomPort() {
        let conf = Configuration(enviroment: ["port":8080,"ssl":false])
        XCTAssertFalse(conf.ssl)
        XCTAssertEqual(conf.port, 8080)
    }
}
