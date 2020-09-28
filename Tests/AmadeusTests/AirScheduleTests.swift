@testable import Amadeus
import XCTest

class AirScheduleTests: XCTestCase {
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

    func testRecommendedLocations() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.schedule.flights.get(params:["carrierCode":"AZ",
                                             "flightNumber":"319",
                                             "scheduledDepartureDate":"2021-03-13"], onCompletion: { result in
                switch result {
                case let .success(response):
                    print(response.data)
                    XCTAssertEqual(response.statusCode, 200)
                case let .failure(error):
                    fatalError(error.localizedDescription)
                }

                expectation.fulfill()

        })

        wait(for: [expectation], timeout: 60)
    }
}
