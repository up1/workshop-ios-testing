import XCTest
@testable import TopMovies

class MyRandomNumberTest: XCTestCase {
    
    func test_random_should_be_5() {
        let my = MyRandomNumber()
        my.xRandom = StubXRandom5()
        let result = my.getNumber()
        XCTAssertEqual(5, result)
    }

}

class StubXRandom5: XRandom {
    override func get() -> Int {
        return 5
    }
}
