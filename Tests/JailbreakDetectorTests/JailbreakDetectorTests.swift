import XCTest
@testable import JailbreakDetector

final class JailbreakDetectorTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(JailbreakDetector(types: [.url]).text, "Hello, World!")
        XCTAssertEqual(JailbreakDetector(types: [.url]).isJB, false)
        XCTAssertEqual(JailbreakDetector(types: [.file]).isJB, false)
        XCTAssertEqual(JailbreakDetector(types: [.sandbox]).isJB, false)
    }
}
