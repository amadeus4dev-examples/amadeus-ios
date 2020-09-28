import Foundation

public class Schedule {
    private let client: Client
    public let flights: FlightsSchedule

    public init(client: Client) {
        self.client = client
        flights = FlightsSchedule(client: client)
    }
}
