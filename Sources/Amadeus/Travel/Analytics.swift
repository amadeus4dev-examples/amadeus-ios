import Foundation

/// A namespaced client for the `v1/travel/analytics` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics
/// ```
public class Analytics{
    
    public let airTraffic:AirTraffic
    
    public init(client:Client){
        airTraffic = AirTraffic(client: client)
    }
}
