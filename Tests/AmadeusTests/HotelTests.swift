@testable import Amadeus
import XCTest
import SwiftyJSON

class HotelTests: XCTestCase {
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
    
    func testHotelOffers() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.shopping.hotelOffers.get(params: ["cityCode": "PAR"], onCompletion: {
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
    
    func testHotelOfferByHotel() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.shopping.hotelOfferByHotel.get(params: ["hotelId": "BGMILBGB",
                                                        "adults": "2",
                                                        "roomQuantity": "1",
                                                        "paymentPolicy": "NONE",
                                                        "view": "FULL_ALL_IMAGES"], onCompletion: { result in
                                                            
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
    
    func testHotelSentiments() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        amadeus.eReputation.hotelSentiments.get(params: ["hotelIds": "TELONMFS,ADNYCCTB,XXXYYY01"],
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
    
    func testHotelOffer() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        let hotelId = "176383FB301E78D430F81A6CB6134EBF801DCC1AE14FC9DCCE84D17C6B519F5B"
        
        amadeus.shopping.hotelOffer(hotelId: hotelId).get(onCompletion: { result in
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
    
    
    func testHotelBookings() {
        let expectation = XCTestExpectation(description: "TimeOut")
        
        let jsonString: String = """
        {
          "data": {
            "offerId": "9AFAD70AF0E4E520F41E1AC743EADB9A1D83EF921A63013CA4E65FA9E8465F4F",
            "guests": [
              {
                "name": {
                  "title": "MR",
                  "firstName": "BOB",
                  "lastName": "SMITH"
                },
                "contact": {
                  "phone": "+33679278416",
                  "email": "bob.smith@email.com"
                }
              }
            ],
            "payments": [
              {
                "method": "creditCard",
                "card": {
                  "vendorCode": "VI",
                  "cardNumber": "4111111111111111",
                  "expiryDate": "2023-01"
                }
              }
            ]
          }
        }
        """
        
        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)
        
        do {
            let body: JSON = try JSON(data: dataFromString!)
            
            amadeus.booking.hotelBookings.post(body: body, onCompletion: {
                result in
                
                switch result {
                case .success(let response):
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
