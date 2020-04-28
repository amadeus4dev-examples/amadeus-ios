import XCTest

#if !os(macOS)
    public func allTests() -> [XCTestCaseEntry] {
        return [
            testCase(AirShoppingTests.allTests),
            testCase(AirBookingTests.allTests),
            testCase(AirAITests.allTests),
            testCase(AirTravelInsightsTests.allTests),
            testCase(AirUtilsTests.allTests),
            testCase(HotelShoppingTests.allTests),
            testCase(CoreTests.allTests),
        ]
    }
#endif
