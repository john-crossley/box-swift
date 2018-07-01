import XCTest
@testable import Box

final class BoxTests: XCTestCase {

    func testItCanParseEnvFileAndReturnValuesForKeys() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let box = Box(envFile: "/Users/jonno/dev/opensource/github/john-crossley/Box/.env")
        XCTAssertEqual(box.get(key: "DATABASE"), "sqlite")
        XCTAssertEqual(box.get(key: "AWS_REGION"), "eu")
    }

    func testItReturnsNilWhenKeyNotFound() {
        let box = Box(envFile: "/Users/jonno/dev/opensource/github/john-crossley/Box/.env")
        XCTAssertNil(box.get(key: "HOWLING_JIMMY_JEFFERSON"))
    }

    func testItReturnsEnvironmentVarIfKeyDoesntExist() {
        setenv("PURPLE_UNICORN", "veggie sausages", 1)
        let box = Box()
        XCTAssertEqual(box.get(key: "PURPLE_UNICORN"), "veggie sausages")
    }

    func testItWillReturnNilWhenNoEnvironmentsFileSpecified() {
        let box = Box()
        XCTAssertNil(box.get(key: "HOT_BOX"))
    }

    func testTheEnvironmentsFileCanBeSetUsingEnvVariables() {
        setenv("ENV_FILE_PATH", "/Users/jonno/dev/opensource/github/john-crossley/Box/.env", 1)
        let box = Box()
        XCTAssertEqual(box.get(key: "FUGGLE"), "wuggle")
    }

    static var allTests = [
        ("testItCanParseEnvFileAndReturnValuesForKeys", testItCanParseEnvFileAndReturnValuesForKeys),
        ("testItReturnsNilWhenKeyNotFound", testItReturnsNilWhenKeyNotFound),
        ("testItReturnsEnvironmentVarIfKeyDoesntExist", testItReturnsEnvironmentVarIfKeyDoesntExist),
        ("testTheEnvironmentsFileCanBeSetUsingEnvVariables", testTheEnvironmentsFileCanBeSetUsingEnvVariables)
    ]
}
