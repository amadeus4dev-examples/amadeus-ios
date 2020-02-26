import XCTest
@testable import Amadeus

class EndpointHotelTests: XCTestCase {
    
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
    

    func testHotelOffers(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.shopping.hotelOffers.get(data:["cityCode": "PAR"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
    
    func testHotelOfferByHotel(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.shopping.hotelOfferByHotel.get(data:["hotelId": "BGMILBGB",
                                                         "adults": "2",
                                                         "roomQuantity": "1",
                                                         "paymentPolicy": "NONE",
                                                         "view": "FULL_ALL_IMAGES"], onCompletion: {
            data,error in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
 
    func testHotelOffer(){
        
        let expectation = XCTestExpectation(description: "TimeOut")
        
        self.client.shopping.hotelOffer(hotelId: "176383FB301E78D430F81A6CB6134EBF801DCC1AE14FC9DCCE84D17C6B519F5B").get(data:[:],
                                                                                                                          onCompletion: {

            data,error in
            XCTAssertNotNil(data)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 60)
        
    }
}
