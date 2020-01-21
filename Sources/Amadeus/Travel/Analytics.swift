import Foundation

/// A namespaced client for the `v2/travel/analytics` endpoints
///
/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.analytics
/// ```
public class Analytics{
    
    public let fareSearch:FareSearch
    public let airTraffic:AirTraffic
    
    public init(client:Client){
        fareSearch = FareSearch(client: client)
        airTraffic = AirTraffic(client: client)
    }
}
