import XCTest
@testable import snake_game_Watch_App

final class SnakeModelTests: XCTestCase {
    
    var sut: SnakeModel!
    
    override func setUp() {
        sut = SnakeModel()
    }
    
    func test_snakeInitialised_with3ElementsAndRightDirection() {
        XCTAssertEqual(3, sut.getLength())
        XCTAssertEqual(Coordinate(x: 5, y: 3), sut[0]!.position)
        XCTAssertEqual(Coordinate(x: 4, y: 3), sut[1]!.position)
        XCTAssertEqual(Coordinate(x: 3, y: 3), sut[2]!.position)
        
        XCTAssertEqual(nil, sut[0]!.directionNext)
        XCTAssertEqual(Direction.left, sut[0]!.directionPrevious)
        XCTAssertEqual(Direction.right, sut[1]!.directionNext)
        XCTAssertEqual(Direction.left, sut[1]!.directionPrevious)
        XCTAssertEqual(Direction.right, sut[2]!.directionNext)
        XCTAssertEqual(nil, sut[2]!.directionPrevious)
    }
    
    func test_snakeMoved_correctlyAdjustsElements() {
        sut.move(withFood: false)
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertEqual(Coordinate(x: 6, y: 3), sut[0]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 3), sut[1]!.position)
        XCTAssertEqual(Coordinate(x: 4, y: 3), sut[2]!.position)
        
        XCTAssertEqual(nil, sut[0]!.directionNext)
        XCTAssertEqual(Direction.left, sut[0]!.directionPrevious)
        XCTAssertEqual(Direction.right, sut[1]!.directionNext)
        XCTAssertEqual(Direction.left, sut[1]!.directionPrevious)
        XCTAssertEqual(Direction.right, sut[2]!.directionNext)
        XCTAssertEqual(nil, sut[2]!.directionPrevious)
    }
    
    func test_moveWithFood_causesSnakeToGrow() {
        sut.move(withFood: true)
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertEqual(true, sut[0]!.hasFood)
        XCTAssertEqual(false, sut[1]!.hasFood)
        XCTAssertEqual(false, sut[2]!.hasFood)
        
        sut.move(withFood: false)
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertEqual(false, sut[0]!.hasFood)
        XCTAssertEqual(true, sut[1]!.hasFood)
        XCTAssertEqual(false, sut[2]!.hasFood)
        
        sut.move(withFood: false)
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertEqual(false, sut[0]!.hasFood)
        XCTAssertEqual(false, sut[1]!.hasFood)
        XCTAssertEqual(true, sut[2]!.hasFood)
        
        sut.move(withFood: false)
        
        XCTAssertEqual(4, sut.getLength())
        XCTAssertEqual(false, sut[0]!.hasFood)
        XCTAssertEqual(false, sut[1]!.hasFood)
        XCTAssertEqual(false, sut[2]!.hasFood)
        XCTAssertEqual(false, sut[3]!.hasFood)
    }
}
