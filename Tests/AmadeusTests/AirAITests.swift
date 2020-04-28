@testable import Amadeus
import SwiftyJSON
import XCTest

class AirAITests: XCTestCase {
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

    func testAirportOnTimePerformance() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.airport.predictions.onTime.get(data: ["airportCode": "JFK",
                                                       "date": "2020-08-01"], onCompletion: {
                data, _ in
                print(data?.data ?? "")
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testFlightDelayPrediction() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.predictions.flightDelay.get(data: ["originLocationCode": "NCE",
                                                          "destinationLocationCode": "IST",
                                                          "departureDate":"2020-08-01",
                                                          "departureTime":"18:20:00",
                                                          "arrivalDate":"2020-08-01",
                                                          "arrivalTime":"22:15:00",
                                                          "aircraftCode":"321",
                                                          "carrierCode":"TK",
                                                          "flightNumber":"1816",
                                                          "duration":"PT31H10M"],
                                                          onCompletion: {
                data, _ in
                print(data?.data ?? "")
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testFlighChoicePrediction() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.flightOffersSearch.get(data: ["originLocationCode": "MAD",
                                                       "destinationLocationCode": "BER",
                                                       "departureDate": "2020-05-16",
                                                       "returnDate": "2020-05-30",
                                                       "adults": "2"], onCompletion: {
               response, error in
               XCTAssertNil(error)

               self.amadeus.shopping.flightOffers.prediction.post(body: response!.result, onCompletion: {
                                                                 prediction, _ in
                                                                 //print(prediction?.data ?? "")
                                                                 XCTAssertEqual(prediction?.statusCode, 200)
                                                                 XCTAssertNotNil(prediction)
                                                                 expectation.fulfill()
                                                             })
        })

        wait(for: [expectation], timeout: 60)
    }
}
