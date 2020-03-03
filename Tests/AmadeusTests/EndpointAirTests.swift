import XCTest
@testable import Amadeus

class EndpointAirTests: XCTestCase {
    
    var amadeus: Amadeus!

    override func setUp() {
        super.setUp()
        
        // Avoid 429 error "Network rate limit is exceeded
        sleep(1)
        
        self.amadeus = Amadeus()
    }

    override func tearDown() {
        self.amadeus = nil
        super.tearDown()
    }

    func testFlightOffersSearch() {
        let expectation = XCTestExpectation(description: "TimeOut")

        self.amadeus.client.get(path: "v1/shopping/flight-destinations",
                               params: ["origin":"MAD",
                                        "maxPrice":"200"], onCompletion: {
            (data, error) in
              XCTAssertEqual(data?.statusCode, 200)
              XCTAssertNotNil(data)
              expectation.fulfill()
        })
       
        wait(for: [expectation], timeout: 60)
 
    }

    func testFlightDestinations(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
       
        self.amadeus.shopping.flightDestinations.get(data: ["origin": "MAD",
                                                            "maxPrice": "500"], onCompletion: {
            (data, error) in
              XCTAssertEqual(data?.statusCode, 200)
              XCTAssertNotNil(data)
              expectation.fulfill()
        })
       
        wait(for: [expectation], timeout: 60)
    }
   
    func testFlightOffers(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.shopping.flightOffers.get(data: ["origin": "MAD",
                                                      "destination": "BER",
                                                      "departureDate": "2020-05-16"], onCompletion: {
            (data,error) in
              XCTAssertEqual(data?.statusCode, 200)
              XCTAssertNotNil(data)
              expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
 
    func testFlightDates(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.shopping.flightDates.get(data:["origin": "MAD",
                                                    "destination": "BOS"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testMostTraveled(){
       
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.travel.analytics.airTraffic.traveled.get(data:["originCityCode": "MAD",
                                                                    "period": "2017-11"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testMostBooked(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.travel.analytics.airTraffic.booked.get(data:["originCityCode": "MAD",
                                                                  "period": "2017-11"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testBusiestPeriod(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.travel.analytics.airTraffic.busiestPeriod.get(data:["cityCode": "MAD",
                                                                         "period": "2017",
                                                                         "direction": "ARRIVING"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    
    func testCheckinLinks(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.referenceData.urls.checkinLinks.get(data:["airlineCode": "BA"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testAirportNearestRelevant(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.referenceData.locations.airports.get(data:["longitude": "2.55",
                                                                "latitude": "49.0000"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            self.amadeus.next(data: data!, onCompletion: {data, err in
                XCTAssertNotNil(data as Any)
                expectation.fulfill()
            })
        })
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testAirportCitySearch(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.referenceData.locations.get(data:["subType": "AIRPORT,CITY",
                                                       "keyword": "lon"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testAirportCitySearchById(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.referenceData.location(locationId: "CMUC").get(data:[:], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testAirLines(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.amadeus.referenceData.airLines.get(data:["airlineCodes": "BA"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
}
