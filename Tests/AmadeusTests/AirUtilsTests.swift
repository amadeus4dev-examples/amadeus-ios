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

        amadeus.referenceData.urls.checkinLinks.get(params: ["airlineCode": "BA"],
                                                    onCompletion: { result in
            switch result {
            case .success(let response):
                print(response.data)
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportNearestRelevant() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.locations.airports.get(params: ["longitude": "2.55",
                                                            "latitude": "49.0000"], onCompletion: {
                result in
                                                                
                                                                switch result {
                                                                case .success(let response):
                                                                    XCTAssertEqual(response.statusCode, 200)
                                                                    
                                                                    self.amadeus.next(response: response, onCompletion: { result in
                                                                        switch result {
                                                                        case .success(let response):
                                                                            break
                                                                        case .failure(let error):
                                                                            fatalError(error.localizedDescription)
                                                                        }
                                                                            expectation.fulfill()
                                                                    })
                                                                    
                                                                case .failure(let error):
                                                                    fatalError(error.localizedDescription)
                                                                }
                
                
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportCitySearch() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.locations.get(params: ["subType": "AIRPORT,CITY",
                                                   "keyword": "lon"], onCompletion: {
                result in
                switch result {
                case .success(let response):
                    print(response.data)
                    XCTAssertEqual(response.statusCode, 200)
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportCitySearchById() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.location(locationId: "CMUC").get(params: [:], onCompletion: {
            result in
            switch result {
            case .success(let response):
                print(response.data)
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirLines() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.airLines.get(params: ["airlineCodes": "BA"], onCompletion: {
            result in
            switch result {
            case .success(let response):
                print(response.data)
                XCTAssertEqual(response.statusCode, 200)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }
}
