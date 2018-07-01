import XCTest
@testable import Box

final class BoxTests: XCTestCase {

    func testItCanParseEnvFileAndReturnValuesForKeys() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let box = Box()
        XCTAssertEqual(box.get(key: "DATABASE"), "sqlite")
        XCTAssertEqual(box.get(key: "AWS_REGION"), "eu")
    }

    func testItReturnsNilWhenKeyNotFound() {
        let box = Box()
        XCTAssertNil(box.get(key: "HOWLING_JIMMY_JEFFERSON"))
    }

    func testItReturnsEnvironmentVarIfKeyDoesntExist() {
        setenv("PURPLE_UNICORN", "veggie sausages", 1)
        let box = Box()
        XCTAssertEqual(box.get(key: "PURPLE_UNICORN"), "veggie sausages")
    }

    static var allTests = [
        ("testItCanParseEnvFileAndReturnValuesForKeys", testItCanParseEnvFileAndReturnValuesForKeys),
        ("testItReturnsNilWhenKeyNotFound", testItReturnsNilWhenKeyNotFound),
        ("testItReturnsEnvironmentVarIfKeyDoesntExist", testItReturnsEnvironmentVarIfKeyDoesntExist)
    ]
}
