import Foundation

/// Access via the `Amadeus` object
/// ```
/// let amadeus = Amadeus(client_id, client_secret)
/// amadeus.travel.predictions
/// ```
public class Predictions {
    public let flightDelay : FlightDelay
    public let tripPurpose : TripPurpose

    // Since we cannot have two 'Predictions' classes under the
    // same module, we need to instantiate onTime here even
    // if it belongs to the endpoint airport/predictions
    public let onTime: OnTime

    public init(client: Client) {
        flightDelay = FlightDelay(client: client)
        tripPurpose = TripPurpose(client: client)
        onTime = OnTime(client: client)
    }
}
