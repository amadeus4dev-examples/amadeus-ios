import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EndpointAirTests.allTests),
        testCase(EndpointHotelTests.allTests),
        testCase(CoreTests.allTests),
    ]
}
#endif
