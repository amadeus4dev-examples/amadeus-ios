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
        
        amadeus.travel.predictions.tripPurpose.get(params: ["originLocationCode": "NYC",
                                                            "destinationLocationCode": "MAD",
                                                            "departureDate":"2020-08-01",
                                                            "returnDate":"2020-08-12",
                                                            "searchDate":"2020-06-11"],
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
    
}

