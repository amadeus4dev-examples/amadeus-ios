@testable import Amadeus
import SwiftyJSON
import XCTest

class AirBookingTests: XCTestCase {
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

    func testFlightOrderRetrieve() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.booking.flightOrder(flightOrderId: "eJzTd9f3NjIJdzUGAAp%2fAiY=").get(onCompletion: {
            result in
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


    func testFlightOrderDelete() {
        let expectation = XCTestExpectation(description: "TimeOut")

        amadeus.booking.flightOrder(flightOrderId: "eJzTd9cPCjX2Mg8HAAs1Alg%3D").delete(onCompletion: {
            result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.statusCode, 204)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 60)
 
    }

    func testFlightCreateOrders() {
        let expectation = XCTestExpectation(description: "TimeOut")

        let jsonString: String = """
        {
          "data": {
            "type": "flight-order",
            "flightOffers": [
              {
                "type": "flight-offer",
                "id": "1",
                "source": "GDS",
                "instantTicketingRequired": false,
                "nonHomogeneous": false,
                "paymentCardRequired": false,
                "lastTicketingDate": "2020-03-01",
                "itineraries": [
                  {
                    "segments": [
                      {
                        "departure": {
                          "iataCode": "GIG",
                          "terminal": "2",
                          "at": "2020-03-01T21:05:00"
                        },
                        "arrival": {
                          "iataCode": "CDG",
                          "terminal": "2E",
                          "at": "2020-03-02T12:20:00"
                        },
                        "carrierCode": "KL",
                        "number": "2410",
                        "aircraft": {
                          "code": "772"
                        },
                        "operating": {
                          "carrierCode": "AF"
                        },
                        "duration": "PT11H15M",
                        "id": "40",
                        "numberOfStops": 0
                      },
                      {
                        "departure": {
                          "iataCode": "CDG",
                          "terminal": "2F",
                          "at": "2020-03-02T14:30:00"
                        },
                        "arrival": {
                          "iataCode": "AMS",
                          "at": "2020-03-02T15:45:00"
                        },
                        "carrierCode": "KL",
                        "number": "1234",
                        "aircraft": {
                          "code": "73H"
                        },
                        "operating": {
                          "carrierCode": "KL"
                        },
                        "duration": "PT1H15M",
                        "id": "41",
                        "numberOfStops": 0
                      },
                      {
                        "departure": {
                          "iataCode": "AMS",
                          "at": "2020-03-02T17:05:00"
                        },
                        "arrival": {
                          "iataCode": "MAD",
                          "terminal": "2",
                          "at": "2020-03-02T19:35:00"
                        },
                        "carrierCode": "KL",
                        "number": "1705",
                        "aircraft": {
                          "code": "73J"
                        },
                        "operating": {
                          "carrierCode": "KL"
                        },
                        "duration": "PT2H30M",
                        "id": "42",
                        "numberOfStops": 0
                      }
                    ]
                  },
                  {
                    "segments": [
                      {
                        "departure": {
                          "iataCode": "MAD",
                          "terminal": "2",
                          "at": "2020-03-05T20:25:00"
                        },
                        "arrival": {
                          "iataCode": "AMS",
                          "at": "2020-03-05T23:00:00"
                        },
                        "carrierCode": "KL",
                        "number": "1706",
                        "aircraft": {
                          "code": "73J"
                        },
                        "operating": {
                          "carrierCode": "KL"
                        },
                        "duration": "PT2H35M",
                        "id": "81",
                        "numberOfStops": 0
                      },
                      {
                        "departure": {
                          "iataCode": "AMS",
                          "at": "2020-03-06T10:40:00"
                        },
                        "arrival": {
                          "iataCode": "GIG",
                          "terminal": "2",
                          "at": "2020-03-06T18:35:00"
                        },
                        "carrierCode": "KL",
                        "number": "705",
                        "aircraft": {
                          "code": "772"
                        },
                        "operating": {
                          "carrierCode": "KL"
                        },
                        "duration": "PT11H55M",
                        "id": "82",
                        "numberOfStops": 0
                      }
                    ]
                  }
                ],
                "price": {
                  "currency": "USD",
                  "total": "8514.96",
                  "base": "8314.00",
                  "fees": [
                    {
                      "amount": "0.00",
                      "type": "SUPPLIER"
                    },
                    {
                      "amount": "0.00",
                      "type": "TICKETING"
                    },
                    {
                      "amount": "0.00",
                      "type": "FORM_OF_PAYMENT"
                    }
                  ],
                  "grandTotal": "8514.96",
                  "billingCurrency": "USD"
                },
                "pricingOptions": {
                  "fareType": [
                    "PUBLISHED"
                  ],
                  "includedCheckedBagsOnly": true
                },
                "validatingAirlineCodes": [
                  "AF"
                ],
                "travelerPricings": [
                  {
                    "travelerId": "1",
                    "fareOption": "STANDARD",
                    "travelerType": "ADULT",
                    "price": {
                      "currency": "USD",
                      "total": "4849.48",
                      "base": "4749.00",
                      "taxes": [
                        {
                          "amount": "31.94",
                          "code": "BR"
                        },
                        {
                          "amount": "14.68",
                          "code": "CJ"
                        },
                        {
                          "amount": "5.28",
                          "code": "FR"
                        },
                        {
                          "amount": "17.38",
                          "code": "JD"
                        },
                        {
                          "amount": "0.69",
                          "code": "OG"
                        },
                        {
                          "amount": "3.95",
                          "code": "QV"
                        },
                        {
                          "amount": "12.12",
                          "code": "QX"
                        },
                        {
                          "amount": "14.44",
                          "code": "RN"
                        }
                      ]
                    },
                    "fareDetailsBySegment": [
                      {
                        "segmentId": "40",
                        "cabin": "BUSINESS",
                        "fareBasis": "CFFBR",
                        "brandedFare": "BUSINESS",
                        "class": "C",
                        "includedCheckedBags": {
                          "quantity": 2
                        }
                      },
                      {
                        "segmentId": "41",
                        "cabin": "BUSINESS",
                        "fareBasis": "CFFBR",
                        "brandedFare": "BUSINESS",
                        "class": "J",
                        "includedCheckedBags": {
                          "quantity": 2
                        }
                      },
                      {
                        "segmentId": "42",
                        "cabin": "BUSINESS",
                        "fareBasis": "CFFBR",
                        "brandedFare": "BUSINESS",
                        "class": "J",
                        "includedCheckedBags": {
                          "quantity": 2
                        }
                      },
                      {
                        "segmentId": "81",
                        "cabin": "ECONOMY",
                        "fareBasis": "YFFBR",
                        "brandedFare": "FULLFLEX",
                        "class": "Y",
                        "includedCheckedBags": {
                          "quantity": 1
                        }
                      },
                      {
                        "segmentId": "82",
                        "cabin": "ECONOMY",
                        "fareBasis": "YFFBR",
                        "brandedFare": "FULLFLEX",
                        "class": "Y",
                        "includedCheckedBags": {
                          "quantity": 1
                        }
                      }
                    ]
                  },
                  {
                    "travelerId": "2",
                    "fareOption": "STANDARD",
                    "travelerType": "CHILD",
                    "price": {
                      "currency": "USD",
                      "total": "3665.48",
                      "base": "3565.00",
                      "taxes": [
                        {
                          "amount": "31.94",
                          "code": "BR"
                        },
                        {
                          "amount": "14.68",
                          "code": "CJ"
                        },
                        {
                          "amount": "5.28",
                          "code": "FR"
                        },
                        {
                          "amount": "17.38",
                          "code": "JD"
                        },
                        {
                          "amount": "0.69",
                          "code": "OG"
                        },
                        {
                          "amount": "3.95",
                          "code": "QV"
                        },
                        {
                          "amount": "12.12",
                          "code": "QX"
                        },
                        {
                          "amount": "14.44",
                          "code": "RN"
                        }
                      ]
                    },
                    "fareDetailsBySegment": [
                      {
                        "segmentId": "40",
                        "cabin": "BUSINESS",
                        "fareBasis": "CFFBR",
                        "brandedFare": "BUSINESS",
                        "class": "C",
                        "includedCheckedBags": {
                          "quantity": 2
                        }
                      },
                      {
                        "segmentId": "41",
                        "cabin": "BUSINESS",
                        "fareBasis": "CFFBR",
                        "brandedFare": "BUSINESS",
                        "class": "J",
                        "includedCheckedBags": {
                          "quantity": 2
                        }
                      },
                      {
                        "segmentId": "42",
                        "cabin": "BUSINESS",
                        "fareBasis": "CFFBR",
                        "brandedFare": "BUSINESS",
                        "class": "J",
                        "includedCheckedBags": {
                          "quantity": 2
                        }
                      },
                      {
                        "segmentId": "81",
                        "cabin": "ECONOMY",
                        "fareBasis": "YFFBR",
                        "brandedFare": "FULLFLEX",
                        "class": "Y",
                        "includedCheckedBags": {
                          "quantity": 1
                        }
                      },
                      {
                        "segmentId": "82",
                        "cabin": "ECONOMY",
                        "fareBasis": "YFFBR",
                        "brandedFare": "FULLFLEX",
                        "class": "Y",
                        "includedCheckedBags": {
                          "quantity": 1
                        }
                      }
                    ]
                  }
                ]
              }
            ],
            "travelers": [
              {
                "id": "1",
                "dateOfBirth": "1982-01-16",
                "name": {
                  "firstName": "JORGE",
                  "lastName": "GONZALES"
                },
                "gender": "MALE",
                "contact": {
                  "emailAddress": "jorge.gonzales833@telefonica.es",
                  "phones": [
                    {
                      "deviceType": "MOBILE",
                      "countryCallingCode": "34",
                      "number": "480080076"
                    }
                  ]
                },
                "documents": [
                  {
                    "documentType": "PASSPORT",
                    "birthPlace": "Madrid",
                    "issuanceLocation": "Madrid",
                    "issuanceDate": "2015-04-14",
                    "number": "00000000",
                    "expiryDate": "2025-04-14",
                    "issuanceCountry": "ES",
                    "validityCountry": "ES",
                    "nationality": "ES",
                    "holder": true
                  }
                ]
              },
              {
                "id": "2",
                "dateOfBirth": "2012-10-11",
                "gender": "FEMALE",
                "contact": {
                  "emailAddress": "jorge.gonzales833@telefonica.es",
                  "phones": [
                    {
                      "deviceType": "MOBILE",
                      "countryCallingCode": "34",
                      "number": "480080076"
                    }
                  ]
                },
                "name": {
                  "firstName": "ADRIANA",
                  "lastName": "GONZALES"
                }
              }
            ],
            "remarks": {
              "general": [
                {
                  "subType": "GENERAL_MISCELLANEOUS",
                  "text": "ONLINE BOOKING FROM INCREIBLE VIAJES"
                }
              ]
            },
            "ticketingAgreement": {
              "option": "DELAY_TO_CANCEL",
              "delay": "6D"
            },
            "contacts": [
              {
                "addresseeName": {
                  "firstName": "PABLO",
                  "lastName": "RODRIGUEZ"
                },
                "companyName": "INCREIBLE VIAJES",
                "purpose": "STANDARD",
                "phones": [
                  {
                    "deviceType": "LANDLINE",
                    "countryCallingCode": "34",
                    "number": "480080071"
                  },
                  {
                    "deviceType": "MOBILE",
                    "countryCallingCode": "33",
                    "number": "480080072"
                  }
                ],
                "emailAddress": "support@increibleviajes.es",
                "address": {
                  "lines": [
                    "Calle Prado, 16"
                  ],
                  "postalCode": "28014",
                  "cityName": "Madrid",
                  "countryCode": "ES"
                }
              }
            ]
          }
        }
        """

        let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false)

        do {
            let body: JSON = try JSON(data: dataFromString!)

            amadeus.booking.flightOrders.post(body: body, onCompletion: {
                result in
                switch result {
                case .success(let response):
                    print(response.data)
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

 
