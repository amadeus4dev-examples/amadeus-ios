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

    func testTripParser() {
        let expectation = XCTestExpectation(description: "TimeOut")

        let jsonString: String = """
        {
          "payload": "",
          "metadata": {
            "documentType": "PDF",
            "name": "BOOKING_DOCUMENT",
            "encoding": "BASE_64"
          }
        }
        """
        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)

        do {
            let body: JSON = try JSON(data: dataFromString!)

            amadeus.travel.tripParser.post(body: body, onCompletion: {
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
        } catch _ as NSError {
            assertionFailure("JSON not valid")
        }
 
        wait(for: [expectation], timeout: 60)
    }

}
