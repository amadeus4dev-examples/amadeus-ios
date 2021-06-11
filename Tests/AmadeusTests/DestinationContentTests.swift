
@testable import Amadeus
import XCTest
import SwiftyJSON

class DestinationContentTests: XCTestCase {
    var amadeus: Amadeus!
    
    override func setUp() {
        super.setUp()
        
        // Avoid 429 error "Network rate limit is exceeded
        sleep(1)
        amadeus = Amadeus(environment: ["logLevel": "debug"])
    }
    
    override func tearDown() {
        amadeus = nil
        super.tearDown()
    }

    func testActivitiesSearch() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.shopping.activities.get(params: ["latitude": "41.397158",
                                                 "longitude": "2.160873"], 
                                        onCompletion: {
                                                            result in
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

    func testActivitiesBySquare() {
        let expectation = XCTestExpectation(description: "TimeOut")

         amadeus.shopping.activities.bySquare.get(params: ["north": "41.397158",
                                                           "west": "2.160873",
                                                           "south": "41.394582",
                                                           "east": "2.177181"], onCompletion: {
                                                            result in
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
    
    func testActivityRetrieve() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.shopping.activity(activityId: "56777").get(onCompletion: {
                                                            result in
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
 
     func testSafePlaceSearch() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.safety.safetyRatedLocations.get(params: ["latitude": "41.397158",
                                                          "longitude": "2.160873",
                                                          "radius": "2"], onCompletion: {
                                                            result in
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
    
     func testSafePlaceBySquare() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.safety.safetyRatedLocations.bySquare.get(params: ["north": "41.397158",
                                                                  "west": "2.160873",
                                                                  "south": "41.394582",
                                                                  "east": "2.177181"], onCompletion: {
                                                            result in
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
    
     func testSafePlaceRetrieve() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.safety.safetyRatedLocation(locationId: "Q930402753").get(onCompletion: {
                                                            result in
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
    
    func testPointsOfInterestSearch() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.referenceData.locations.pointsOfInterest.get(params: ["latitude": "41.397158",
                                                                      "longitude": "2.160873",
                                                                      "radius": "2"], onCompletion: {
                                                                        result in
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
    
    func testPointsOfInterestSearchBySquare() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.referenceData.locations.pointsOfInterest.bySquare.get(params: ["north": "41.397158",
                                                                               "west": "2.160873",
                                                                               "south": "41.394582",
                                                                               "east": "2.177181"],
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
    
    func testPointsOfInterestRetrieve() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.referenceData.locations.pointOfInterest(poiId: "8DA7B6CDCA").get(
            onCompletion: {
                result in
                
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
    
    func testLocationScore() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.location.analytics.categoryRatedAreas.get(params: ["latitude": "41.397158",
                                                                      "longitude": "2.160873"], onCompletion: {
                                                                        result in
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

