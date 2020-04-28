@testable import Amadeus
import SwiftyJSON
import XCTest

class TripAITests: XCTestCase {
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

    func testTripPurposePrediction() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.predictions.tripPurpose.get(data: ["originLocationCode": "NYC",
                                                          "destinationLocationCode": "MAD",
                                                          "departureDate":"2020-08-01",
                                                          "returnDate":"2020-08-12",
                                                          "searchDate":"2020-06-11"],
                                                          onCompletion: {
                data, _ in
                print(data?.data ?? "")
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }


    func testAIGeneratedPhotos() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.media.files.generatedPhotos.get(data: ["category": "MOUNTAIN"],
                                                onCompletion: {
                data, _ in
                print(data?.data ?? "")
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }
}

