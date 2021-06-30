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

    func testFlightPriceAnalysis() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.analytics.itineraryPriceMetrics.get(params: ["originIataCode": "MAD",
                                                             "destinationIataCode": "CDG",
                                                             "departureDate": "2021-01-15"],
                                                    onCompletion: { result in
                switch result {
                case let .success(response):
                    XCTAssertEqual(response.statusCode, 200)
                case let .failure(error):
                    fatalError(error.localizedDescription)
                }

                expectation.fulfill()

        })

        wait(for: [expectation], timeout: 60)
    }
    
    func testRecommendedLocations() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.recommendedLocations.get(params: ["cityCodes": "MAD",
                                                                "travelerCountryCode": "FR"],
                                                       onCompletion: { result in

                switch result {
                case let .success(response):
                    print(response.data)
                    XCTAssertEqual(response.statusCode, 200)
                case let .failure(error):
                    fatalError(error.localizedDescription)
                }

                expectation.fulfill()

        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportOnTimePerformance() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.airport.predictions.onTime.get(params: ["airportCode": "JFK",
                                                        "date": "2020-08-01"], onCompletion: { result in

                switch result {
                case let .success(response):
                    print(response.data)
                    XCTAssertEqual(response.statusCode, 200)
                case let .failure(error):
                    fatalError(error.localizedDescription)
                }

                expectation.fulfill()

        })

        wait(for: [expectation], timeout: 60)
    }

    func testFlightDelayPrediction() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.predictions.flightDelay.get(params: ["originLocationCode": "NCE",
                                                            "destinationLocationCode": "IST",
                                                            "departureDate": "2020-08-01",
                                                            "departureTime": "18:20:00",
                                                            "arrivalDate": "2020-08-01",
                                                            "arrivalTime": "22:15:00",
                                                            "aircraftCode": "321",
                                                            "carrierCode": "TK",
                                                            "flightNumber": "1816",
                                                            "duration": "PT31H10M"],
                                                   onCompletion: {
                                                       result in

                                                       switch result {
                                                       case let .success(response):
                                                           XCTAssertEqual(response.statusCode, 200)
                                                       case let .failure(error):
                                                           fatalError(error.localizedDescription)
                                                       }

                                                       expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testFlighChoicePrediction() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.flightOffersSearch.get(params: ["originLocationCode": "MAD",
                                                         "destinationLocationCode": "BER",
                                                         "departureDate": "2021-12-16",
                                                         "returnDate": "2021-12-30",
                                                         "adults": "2"], onCompletion: {
                result in

                switch result {
                case let .success(response):
                    self.amadeus.shopping.flightOffers.prediction.post(body: response.result, onCompletion: {
                        predictionResult in

                        switch predictionResult {
                        case let .success(response):
                            XCTAssertEqual(response.statusCode, 200)
                        case let .failure(error):
                            fatalError(error.localizedDescription)
                        }

                        expectation.fulfill()
                    })
                case let .failure(error):
                    fatalError(error.localizedDescription)
                }

        })

        wait(for: [expectation], timeout: 60)
    }
}
