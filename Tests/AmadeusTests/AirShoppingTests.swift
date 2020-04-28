@testable import Amadeus
import SwiftyJSON
import XCTest

class AirShoppingTests: XCTestCase {
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
                //print(data?.data)
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
                //print(data?.data ?? "")
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

    func testFlightOffersPrice() {

        let jsonString: String = """
        [{
          "oneWay" : false,
          "numberOfBookableSeats" : 3,
          "nonHomogeneous" : false,
          "validatingAirlineCodes" : [
            "LX"
            ],
            "instantTicketingRequired" : false,
            "price" : {
              "currency" : "EUR",
              "base" : "76.00",
              "total" : "331.98",
              "fees" : [
                {
                  "amount" : "0.00",
                  "type" : "SUPPLIER"
                },
                {
                  "amount" : "0.00",
                  "type" : "TICKETING"
                }
              ],
              "grandTotal" : "331.98",
              "additionalServices" : [
                {
                  "type" : "CHECKED_BAGS",
                  "amount" : "30.00"
                }
              ]
            },
            "lastTicketingDate" : "2020-04-24",
            "itineraries" : [
              {
                "segments" : [
                  {
                    "numberOfStops" : 0,
                    "operating" : {
                      "carrierCode" : "LX"
                    },
                    "arrival" : {
                      "at" : "2020-05-16T12:10:00",
                      "iataCode" : "ZRH"
                    },
                    "number" : "2021",
                    "blacklistedInEU" : false,
                    "carrierCode" : "LX",
                    "departure" : {
                      "iataCode" : "MAD",
                      "at" : "2020-05-16T09:55:00",
                      "terminal" : "2"
                    },
                    "id" : "8",
                    "duration" : "PT2H15M",
                    "aircraft" : {
                      "code" : "223"
                    }
                  },
                  {
                    "carrierCode" : "LX",
                    "number" : "970",
                    "id" : "9",
                    "duration" : "PT1H25M",
                    "arrival" : {
                      "at" : "2020-05-16T18:00:00",
                      "iataCode" : "TXL"
                    },
                    "aircraft" : {
                      "code" : "E90"
                    },
                    "numberOfStops" : 0,
                    "blacklistedInEU" : false,
                    "departure" : {
                      "iataCode" : "ZRH",
                      "at" : "2020-05-16T16:35:00"
                    },
                    "operating" : {
                      "carrierCode" : "2L"
                    }
                  }
                ],
                "duration" : "PT8H5M"
              },
              {
                "segments" : [
                  {
                    "operating" : {
                      "carrierCode" : "LH"
                    },
                    "duration" : "PT1H10M",
                    "aircraft" : {
                      "code" : "32A"
                    },
                    "numberOfStops" : 0,
                    "id" : "117",
                    "arrival" : {
                      "iataCode" : "MUC",
                      "at" : "2020-05-30T12:05:00",
                      "terminal" : "2"
                    },
                    "blacklistedInEU" : false,
                    "number" : "1935",
                    "departure" : {
                      "iataCode" : "TXL",
                      "at" : "2020-05-30T10:55:00"
                    },
                    "carrierCode" : "LH"
                  },
                  {
                    "arrival" : {
                      "iataCode" : "MAD",
                      "at" : "2020-05-30T18:40:00",
                      "terminal" : "2"
                    },
                    "departure" : {
                      "iataCode" : "MUC",
                      "at" : "2020-05-30T16:00:00",
                      "terminal" : "2"
                    },
                    "duration" : "PT2H40M",
                    "id" : "118",
                    "operating" : {
                      "carrierCode" : "LH"
                    },
                    "aircraft" : {
                      "code" : "319"
                    },
                    "blacklistedInEU" : false,
                    "carrierCode" : "LH",
                    "numberOfStops" : 0,
                    "number" : "7038"
                  }
                ],
                "duration" : "PT7H45M"
              }
            ],
            "pricingOptions" : {
              "includedCheckedBagsOnly" : false,
              "fareType" : [
                "PUBLISHED"
              ]
            },
            "id" : "1",
            "type" : "flight-offer",
            "travelerPricings" : [
              {
                "fareDetailsBySegment" : [
                  {
                    "segmentId" : "8",
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "class" : "L",
                    "fareBasis" : "L03LGTE2",
                    "brandedFare" : "LIGHT",
                    "cabin" : "ECONOMY"
                  },
                  {
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "cabin" : "ECONOMY",
                    "fareBasis" : "L03LGTE2",
                    "class" : "L",
                    "segmentId" : "9",
                    "brandedFare" : "LIGHT"
                  },
                  {
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "cabin" : "ECONOMY",
                    "fareBasis" : "K03LGTE3",
                    "class" : "K",
                    "segmentId" : "117",
                    "brandedFare" : "LIGHT"
                  },
                  {
                    "brandedFare" : "LIGHT",
                    "segmentId" : "118",
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "class" : "K",
                    "fareBasis" : "K03LGTE3",
                    "cabin" : "ECONOMY"
                  }
                ],
                "fareOption" : "STANDARD",
                "travelerId" : "1",
                "travelerType" : "ADULT",
                "price" : {
                  "base" : "38.00",
                  "total" : "165.99",
                  "currency" : "EUR"
                }
              },
              {
                "fareOption" : "STANDARD",
                "fareDetailsBySegment" : [
                  {
                    "class" : "L",
                    "brandedFare" : "LIGHT",
                    "segmentId" : "8",
                    "fareBasis" : "L03LGTE2",
                    "cabin" : "ECONOMY",
                    "includedCheckedBags" : {
                      "quantity" : 0
                    }
                  },
                  {
                    "class" : "L",
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "brandedFare" : "LIGHT",
                    "segmentId" : "9",
                    "cabin" : "ECONOMY",
                    "fareBasis" : "L03LGTE2"
                  },
                  {
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "fareBasis" : "K03LGTE3",
                    "cabin" : "ECONOMY",
                    "class" : "K",
                    "brandedFare" : "LIGHT",
                    "segmentId" : "117"
                  },
                  {
                    "includedCheckedBags" : {
                      "quantity" : 0
                    },
                    "fareBasis" : "K03LGTE3",
                    "cabin" : "ECONOMY",
                    "class" : "K",
                    "brandedFare" : "LIGHT",
                    "segmentId" : "118"
                  }
                ],
                "travelerId" : "2",
                "travelerType" : "ADULT",
                "price" : {
                  "base" : "38.00",
                  "total" : "165.99",
                  "currency" : "EUR"
                }
              }
            ],
            "source" : "GDS"
        }]
        """
        let expectation = XCTestExpectation(description: "TimeOut")

        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)

        do {
            let body: JSON = try JSON(data: dataFromString!)

            amadeus.shopping.flightOffers.pricing.post(body: body, onCompletion: {
                                                           data, _ in
                                                           XCTAssertEqual(data?.statusCode, 200)
                                                           XCTAssertNotNil(data)
                                                           expectation.fulfill()
                                                       })
            wait(for: [expectation], timeout: 60)
        
        } catch _ as NSError {
            assertionFailure("JSON not valid")
        }
    }

    func testSeatMapsGet() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.shopping.seatMaps.get(data: ["flight-orderId":"eJzTd9f3NjIJdzUGAAp%2fAiY="],
                                      onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
    }


    func testSeatMapsPost() {

        let jsonString: String = """
        {
            "data": [
                {
                    "type": "flight-offer",
                    "id": "1",
                    "source": "GDS",
                    "instantTicketingRequired": false,
                    "nonHomogeneous": false,
                    "oneWay": false,
                    "lastTicketingDate": "2020-03-07",
                    "numberOfBookableSeats": 9,
                    "itineraries": [
                        {
                            "duration": "PT15H15M",
                            "segments": [
                                {
                                    "departure": {
                                        "iataCode": "NCE",
                                        "terminal": "1",
                                        "at": "2020-09-26T06:00:00"
                                    },
                                    "arrival": {
                                        "iataCode": "LIS",
                                        "terminal": "1",
                                        "at": "2020-09-26T07:35:00"
                                    },
                                    "carrierCode": "TP",
                                    "number": "481",
                                    "aircraft": {
                                        "code": "E90"
                                    },
                                    "operating": {
                                        "carrierCode": "NI"
                                    },
                                    "duration": "PT2H35M",
                                    "id": "33",
                                    "numberOfStops": 0,
                                    "blacklistedInEU": false
                                },
                                {
                                    "departure": {
                                        "iataCode": "LIS",
                                        "terminal": "1",
                                        "at": "2020-09-26T12:15:00"
                                    },
                                    "arrival": {
                                        "iataCode": "EWR",
                                        "terminal": "B",
                                        "at": "2020-09-26T15:15:00"
                                    },
                                    "carrierCode": "TP",
                                    "number": "201",
                                    "aircraft": {
                                        "code": "339"
                                    },
                                    "operating": {
                                        "carrierCode": "TP"
                                    },
                                    "duration": "PT8H",
                                    "id": "34",
                                    "numberOfStops": 0,
                                    "blacklistedInEU": false
                                }
                            ]
                        }
                    ],
                    "price": {
                        "currency": "EUR",
                        "total": "238.23",
                        "base": "52.00",
                        "fees": [
                            {
                                "amount": "0.00",
                                "type": "SUPPLIER"
                            },
                            {
                                "amount": "0.00",
                                "type": "TICKETING"
                            }
                        ],
                        "grandTotal": "238.23",
                        "additionalServices": [
                            {
                                "amount": "75.00",
                                "type": "CHECKED_BAGS"
                            }
                        ]
                    },
                    "pricingOptions": {
                        "fareType": [
                            "PUBLISHED"
                        ],
                        "includedCheckedBagsOnly": false
                    },
                    "validatingAirlineCodes": [
                        "TP"
                    ],
                    "travelerPricings": [
                        {
                            "travelerId": "1",
                            "fareOption": "STANDARD",
                            "travelerType": "ADULT",
                            "price": {
                                "currency": "EUR",
                                "total": "238.23",
                                "base": "52.00"
                            },
                            "fareDetailsBySegment": [
                                {
                                    "segmentId": "33",
                                    "cabin": "ECONOMY",
                                    "fareBasis": "EFRDSI0D",
                                    "brandedFare": "DISCOUNT",
                                    "class": "E",
                                    "includedCheckedBags": {
                                        "quantity": 0
                                    }
                                },
                                {
                                    "segmentId": "34",
                                    "cabin": "ECONOMY",
                                    "fareBasis": "EFRDSI0D",
                                    "brandedFare": "DISCOUNT",
                                    "class": "E",
                                    "includedCheckedBags": {
                                        "quantity": 0
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        """
        let expectation = XCTestExpectation(description: "TimeOut")

        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)

        do {
            let body: JSON = try JSON(data: dataFromString!)

            amadeus.shopping.seatMaps.post(body: body, onCompletion: {
                data, _ in
                XCTAssertEqual(data?.statusCode, 200)
                XCTAssertNotNil(data)
                expectation.fulfill()
                })
            wait(for: [expectation], timeout: 60)
        
        } catch _ as NSError {
            assertionFailure("JSON not valid")
        }
    }

}
