@testable import Amadeus
import XCTest

class HotelShoppingTests: XCTestCase {
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

        amadeus.shopping.hotelOffers.get(data: ["cityCode": "PAR"], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testHotelOfferByHotel() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.hotelOfferByHotel.get(data: ["hotelId": "BGMILBGB",
                                                      "adults": "2",
                                                      "roomQuantity": "1",
                                                      "paymentPolicy": "NONE",
                                                      "view": "FULL_ALL_IMAGES"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testHotelOffer() {
        let expectation = XCTestExpectation(description: "TimeOut")

        let hotelId = "176383FB301E78D430F81A6CB6134EBF801DCC1AE14FC9DCCE84D17C6B519F5B"

        amadeus.shopping.hotelOffer(hotelId: hotelId).get(data: [:],
                                                          onCompletion: {
                                                              data, _ in
                                                              XCTAssertNotNil(data)
                                                              expectation.fulfill()
                                                          })

        wait(for: [expectation], timeout: 60)
    }
}
