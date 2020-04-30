@testable import Amadeus
import SwiftyJSON
import XCTest

class AirUtilsTests: XCTestCase {
    var amadeus: Amadeus!

    override func setUp() {
        super.setUp()

        // Avoid 429 error "Network rate limit is exceeded"
        sleep(1)

        amadeus = Amadeus(environment: ["logLevel": "debug"])
    }

    override func tearDown() {
        amadeus = nil
        super.tearDown()
    }

   func testCheckinLinks() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.urls.checkinLinks.get(params: ["airlineCode": "BA"], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportNearestRelevant() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.locations.airports.get(params: ["longitude": "2.55",
                                                            "latitude": "49.0000"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                self.amadeus.next(response: data!, onCompletion: { data, _ in
                    XCTAssertNotNil(data as Any)
                    expectation.fulfill()
            })
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportCitySearch() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.locations.get(params: ["subType": "AIRPORT,CITY",
                                                   "keyword": "lon"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportCitySearchById() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.location(locationId: "CMUC").get(params: [:], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirLines() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.airLines.get(params: ["airlineCodes": "BA"], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }
}
