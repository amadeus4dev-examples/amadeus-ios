import Foundation

/// A namespaced client for the `v1/travel/analytics/air-traffic` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics.airTraffic
/// ```
public class AirTraffic{
    
    public let traveled:Traveled
    public let booked:Booked
    public let busiestPeriod:BusiestPeriod
    
    public init(client:Client){
        traveled = Traveled(client: client)
        booked = Booked(client: client)
        busiestPeriod = BusiestPeriod(client: client)
    }
}
