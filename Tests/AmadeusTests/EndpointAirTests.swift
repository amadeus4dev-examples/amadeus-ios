import XCTest
@testable import Amadeus

class EndpointAirTests: XCTestCase {
    
    var client : Amadeus!

    override func setUp() {
        super.setUp()
        
        // Avoid 429 error "Network rate limit is exceeded
        sleep(1)
        
        self.client = Amadeus()
    }

    override func tearDown() {
        self.client = nil
        super.tearDown()
    }
    
    func testFlightOffers(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.shopping.flightOffers.get(data: ["origin": "MAD",
                                                     "destination": "BER",
                                                     "departureDate": "2020-05-16"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testFlightDestinations(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.shopping.flightDestinations.get(data: ["origin": "MAD",
                                                           "maxPrice": "500"], onCompletion: {
            data, error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testFlightDates(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.shopping.flightDates.get(data:["origin": "MAD",
                                                   "destination": "BOS"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testMostTraveled(){
       
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.travel.analytics.airTraffic.traveled.get(data:["originCityCode": "MAD", "period": "2017-11"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testMostBooked(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.travel.analytics.airTraffic.booked.get(data:["originCityCode": "MAD", "period": "2017-11"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testBusiestPeriod(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.travel.analytics.airTraffic.busiestPeriod.get(data:["cityCode": "MAD", "period": "2017", "direction": "ARRIVING"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    
    func testCheckinLinks(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.referenceData.urls.checkinLinks.get(data:["airlineCode": "BA"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testAirportNearestRelevant(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.referenceData.locations.airports.get(data:["longitude": "2.55",
                                                               "latitude": "49.0000"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            self.client.next(data: data!, onCompletion: {data, err in
                XCTAssertNotNil(data as Any)
                expectation.fulfill()
            })
        })
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testAirportCitySearch(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.referenceData.locations.get(data:["subType": "AIRPORT,CITY", "keyword": "lon"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testAirportCitySearchById(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.referenceData.location(locationId: "CMUC").get(data:[:], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testAirLines(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.referenceData.airLines.get(data:["airlineCodes": "BA"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.responseCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }

}
