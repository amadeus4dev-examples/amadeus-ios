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
        
        amadeus.travel.analytics.airTraffic.traveled.get(params: ["originCityCode": "MAD",
                                                                  "period": "2017-11"],
                                                         onCompletion: { result  in
                                                            switch result {
                                                            case .success(let response):
                                                                XCTAssertEqual(response.statusCode, 200)
                                                            case .failure(let error):
                                                                fatalError(error.localizedDescription)
                                                            }
                                                            
                                                            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testMostBooked() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.travel.analytics.airTraffic.booked.get(params: ["originCityCode": "MAD",
                                                                "period": "2017-11"],
                                                       onCompletion: { result in
                                                        switch result {
                                                        case .success(let response):
                                                            XCTAssertEqual(response.statusCode, 200)
                                                        case .failure(let error):
                                                            fatalError(error.localizedDescription)
                                                        }
                                                        
                                                        expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testBusiestPeriod() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.travel.analytics.airTraffic.busiestPeriod.get(params: ["cityCode": "MAD",
                                                                       "period": "2017",
                                                                       "direction": "ARRIVING"],
                                                              onCompletion: { result in
                                                                switch result {
                                                                case .success(let response):
                                                                    XCTAssertEqual(response.statusCode, 200)
                                                                case .failure(let error):
                                                                    fatalError(error.localizedDescription)
                                                                }
                                                                
                                                                expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
    }
    
}
