import Amadeus
import Foundation

var amadeus: Amadeus!

amadeus = Amadeus()

amadeus.shopping.flightDestinations.get(data: ["origin": "MAD", "maxPrice": "200"], onCompletion: {
                                            (result, error) in
                                            if error == nil {
                                                print("Code ", result?.responseCode)
                                                print("Data ", result?.body)
                                            }
                                        })
RunLoop.main.run()

