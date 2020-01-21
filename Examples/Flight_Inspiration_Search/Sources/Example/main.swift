import Amadeus
import Foundation

var client_id  = ProcessInfo.processInfo.environment["AMADEUS_CLIENT_ID"]!
var secret_id  = ProcessInfo.processInfo.environment["AMADEUS_CLIENT_SECRET"]!

var amadeus: Amadeus!

amadeus = Amadeus(client_id: client_id, client_secret: secret_id)


// Flight Inspiration Search
amadeus.shopping.flightDestinations.get(data: ["origin": "MAD", "maxPrice": "200"], onCompletion: {
                                            (result, error) in
                                            if error == nil {
                                                print("Code ", result?.responseCode)
                                                print("Data ", result?.body)
                                            }
                                        })

RunLoop.main.run()

