import XCTest
@testable import SlackStatusBar

final class SlackStatusBarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SlackStatusBar().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
