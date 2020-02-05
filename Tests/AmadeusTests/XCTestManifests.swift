import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EndpointAirTests.allTests),
        testCase(EndpointHotelTests.allTests),
        testCase(AmadeusTests.allTests),
    ]
}
#endif
