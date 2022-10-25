import XCTest
@testable import snake_game_Watch_App

final class ShiftRegisterTests: XCTestCase {

    var sut: ShiftRegister<MockElement>!
    
    override func setUp() {
        sut = ShiftRegister<MockElement>()
    }
    
    func test_push_whenCountZero_retainsEmptyArray() {
        let testElement = MockElement(label: 1)
        sut.push(testElement)
        XCTAssertEqual(sut.count, 0)
        XCTAssertNil(sut[0])
    }

    func test_push_newElement_whenCountGreaterThanZero_dropsLastElement() {
        setupWithCount(4)
        
        XCTAssertEqual(sut[3]!.label, 1)
        
        sut.push(MockElement(label: 5))
        
        XCTAssertEqual(sut[3]!.label, 2)
        XCTAssertNil(sut[4])
    }
    
    func test_push_newElement_whenCountHasBeenIncreased_addsNewElementToFront() {
        setupWithCount(4)
        
        sut.count = 5
        
        sut.push(MockElement(label: 5))
        sut.push(MockElement(label: 6))
        
        XCTAssertEqual(sut[0]!.label, 6)
        XCTAssertEqual(sut[1]!.label, 5)
        XCTAssertEqual(sut[2]!.label, 4)
        XCTAssertEqual(sut[3]!.label, 3)
        XCTAssertEqual(sut[4]!.label, 2)
        XCTAssertNil(sut[5])
    }
    
    func test_reducingCount_removesElementsFromTheEnd() {
        setupWithCount(5)
        
        XCTAssertEqual(sut[4]!.label, 1)
        
        sut.count = 3
        
        XCTAssertNil(sut[4])
        XCTAssertNil(sut[3])
        XCTAssertEqual(sut[2]!.label, 3)
    }
    
    func setupWithCount(_ count: Int) {
        sut.count = count
        for n in 1...count {
            sut.push(MockElement(label: n))
        }
    }
}

struct MockElement {
    let label: Int
}
