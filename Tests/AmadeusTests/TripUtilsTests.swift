@testable import Amadeus
import SwiftyJSON
import XCTest

class TripUtilsTests: XCTestCase {
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

    func testTripParserJobs() {
        let expectation = XCTestExpectation(description: "TimeOut")

        let jsonString: String = """
        {
         "data": {
            "type": "trip-parser-job",
            "content": ""
          }
        }
        """
        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)

        do {
            let body: JSON = try JSON(data: dataFromString!)

             amadeus.travel.tripParserJobs.post(body: body,
                                                onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
            })
        } catch _ as NSError {
            assertionFailure("JSON not valid")
        }
 
        wait(for: [expectation], timeout: 60)
    }

    func testTripParserStatus() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.tripParserJobs.status(jobId: "XXX").get(onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testTripParserResult() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.tripParserJobs.result(jobId: "XXX").get(onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

}
