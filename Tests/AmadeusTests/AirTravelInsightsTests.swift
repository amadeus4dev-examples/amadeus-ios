@testable import Amadeus
import SwiftyJSON
import XCTest

class AirTravelInsightsTests: XCTestCase {
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


    func testMostTraveled() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.analytics.airTraffic.traveled.get(data: ["originCityCode": "MAD",
                                                                "period": "2017-11"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testMostBooked() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.analytics.airTraffic.booked.get(data: ["originCityCode": "MAD",
                                                              "period": "2017-11"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testBusiestPeriod() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.analytics.airTraffic.busiestPeriod.get(data: ["cityCode": "MAD",
                                                                     "period": "2017",
                                                                     "direction": "ARRIVING"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

}
