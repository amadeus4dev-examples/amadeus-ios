@testable import Amadeus
import SwiftyJSON
import XCTest

class EndpointAirTests: XCTestCase {
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

    func testFlightDestinations() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.flightDestinations.get(data: ["origin": "MAD",
                                                       "maxPrice": "500"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testFlightOffersSearchGet() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.flightOffersSearch.get(data: ["originLocationCode": "MAD",
                                                       "destinationLocationCode": "BER",
                                                       "departureDate": "2020-05-16",
                                                       "returnDate": "2020-05-30",
                                                       "adults": "2"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testFlightOffersSearchPost() {
        let expectation = XCTestExpectation(description: "TimeOut")

        let jsonString: String = """
        {
            "currencyCode": "USD",
            "originDestinations": [
                {
                    "id": "1",
                    "originLocationCode": "RIO",
                    "destinationLocationCode": "MAD",
                    "departureDateTimeRange": {
                        "date": "2020-08-01",
                        "time": "10:00:00"
                    }
                },
                {
                    "id": "2",
                    "originLocationCode": "MAD",
                    "destinationLocationCode": "RIO",
                    "departureDateTimeRange": {
                        "date": "2020-08-05",
                        "time": "17:00:00"
                    }
                }
            ],
            "travelers": [
                {
                    "id": "1",
                    "travelerType": "ADULT",
                    "fareOptions": [
                        "STANDARD"
                    ]
                },
                {
                    "id": "2",
                    "travelerType": "CHILD",
                    "fareOptions": [
                        "STANDARD"
                    ]
                }
            ],
            "sources": [
                "GDS"
            ],
            "searchCriteria": {
                "maxFlightOffers": 2,
                "flightFilters": {
                    "cabinRestrictions": [
                        {
                            "cabin": "BUSINESS",
                            "coverage": "MOST_SEGMENTS",
                            "originDestinationIds": [
                                "1"
                            ]
                        }
                    ],
                    "carrierRestrictions": {
                        "excludedCarrierCodes": [
                            "AA",
                            "TP",
                            "AZ"
                        ]
                    }
                }
            }
        }  
        """

        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)
        do {
            let body: JSON = try JSON(data: dataFromString!)

            amadeus.shopping.flightOffersSearch.post(body: body, onCompletion: {
                data, _ in
                print(data?.body ?? "")
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
                                                         })

            wait(for: [expectation], timeout: 60)

        } catch _ as NSError {
            assertionFailure("JSON not valid")
        }
    }

    func testFlightDates() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.flightDates.get(data: ["origin": "MAD",
                                                "destination": "BOS"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testMostTraveled() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.analytics.airTraffic.traveled.get(data: ["originCityCode": "MAD",
                                                                "period": "2017-11"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testMostBooked() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.analytics.airTraffic.booked.get(data: ["originCityCode": "MAD",
                                                              "period": "2017-11"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testBusiestPeriod() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.travel.analytics.airTraffic.busiestPeriod.get(data: ["cityCode": "MAD",
                                                                     "period": "2017",
                                                                     "direction": "ARRIVING"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testCheckinLinks() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.urls.checkinLinks.get(data: ["airlineCode": "BA"], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportNearestRelevant() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.locations.airports.get(data: ["longitude": "2.55",
                                                            "latitude": "49.0000"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                self.amadeus.next(data: data!, onCompletion: { data, _ in
                    XCTAssertNotNil(data as Any)
                    expectation.fulfill()
            })
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportCitySearch() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.locations.get(data: ["subType": "AIRPORT,CITY",
                                                   "keyword": "lon"], onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirportCitySearchById() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.location(locationId: "CMUC").get(data: [:], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }

    func testAirLines() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.referenceData.airLines.get(data: ["airlineCodes": "BA"], onCompletion: {
            data, _ in
            XCTAssertEqual(data?.statusCode, 200)
            XCTAssertNotNil(data)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }
}
