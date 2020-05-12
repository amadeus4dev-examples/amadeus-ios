import Foundation

public class FlightOrder {
    private var client: Client
    private var flightOrderId: String
    
    public init(client: Client, flightOrderId: String) {
        self.client = client
        self.flightOrderId = flightOrderId
    }
    
    /// Retrieves a flight order based on its ID.
    public func get(onCompletion: @escaping AmadeusResponse) {
        client.get(path: "v1/booking/flight-orders/\(self.flightOrderId)", params: [:], onCompletion: {
            result in
            onCompletion(result)
        })
    }
    
    /// Deletes a flight order based on its ID.
    public func delete(onCompletion: @escaping AmadeusResponse) {
        client.delete(path: "v1/booking/flight-orders/\(self.flightOrderId)", params: [:], onCompletion: {
            result in
            onCompletion(result)
        })
    }
}
