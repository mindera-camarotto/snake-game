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
        XCTAssertEqual(Direction.west, sut[0]!.directionPrevious)
        XCTAssertEqual(Direction.east, sut[1]!.directionNext)
        XCTAssertEqual(Direction.west, sut[1]!.directionPrevious)
        XCTAssertEqual(Direction.east, sut[2]!.directionNext)
        XCTAssertEqual(nil, sut[2]!.directionPrevious)
    }
    
    func test_snakeMoved_correctlyAdjustsElements() {
        sut.move()
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertEqual(Coordinate(x: 6, y: 3), sut[0]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 3), sut[1]!.position)
        XCTAssertEqual(Coordinate(x: 4, y: 3), sut[2]!.position)
        
        XCTAssertEqual(nil, sut[0]!.directionNext)
        XCTAssertEqual(Direction.west, sut[0]!.directionPrevious)
        XCTAssertEqual(Direction.east, sut[1]!.directionNext)
        XCTAssertEqual(Direction.west, sut[1]!.directionPrevious)
        XCTAssertEqual(Direction.east, sut[2]!.directionNext)
        XCTAssertEqual(nil, sut[2]!.directionPrevious)
    }
    
    func test_moveWithFood_causesSnakeToGrow() {
        sut.move(withFood: true)
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertTrue(sut[0]!.hasFood)
        XCTAssertFalse(sut[1]!.hasFood)
        XCTAssertFalse(sut[2]!.hasFood)
        
        sut.move()
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertFalse(sut[0]!.hasFood)
        XCTAssertTrue(sut[1]!.hasFood)
        XCTAssertFalse(sut[2]!.hasFood)
        
        sut.move()
        
        XCTAssertEqual(3, sut.getLength())
        XCTAssertFalse(sut[0]!.hasFood)
        XCTAssertFalse(sut[1]!.hasFood)
        XCTAssertTrue(sut[2]!.hasFood)
        
        sut.move()
        
        XCTAssertEqual(4, sut.getLength())
        XCTAssertFalse(sut[0]!.hasFood)
        XCTAssertFalse(sut[1]!.hasFood)
        XCTAssertFalse(sut[2]!.hasFood)
        XCTAssertFalse(sut[3]!.hasFood)
    }
    
    func test_turning_causesSnakeToTurn() {
        sut.turn(.left)
        
        sut.move()
        XCTAssertEqual(Coordinate(x: 5, y: 4), sut[0]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 3), sut[1]!.position)
        XCTAssertEqual(Coordinate(x: 4, y: 3), sut[2]!.position)
        
        sut.move()
        XCTAssertEqual(Coordinate(x: 5, y: 5), sut[0]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 4), sut[1]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 3), sut[2]!.position)
        
        sut.move()
        XCTAssertEqual(Coordinate(x: 5, y: 6), sut[0]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 5), sut[1]!.position)
        XCTAssertEqual(Coordinate(x: 5, y: 4), sut[2]!.position)
    }
    
    func test_snakeNotTouchingSelf_doesNotReportTouchingSelf() {
        XCTAssertFalse(sut.isTouchingSelf())
    }
    
    func test_snakeTouchingSelf_doesReportTouchingSelf() {
        sut.move(withFood: true)
        sut.move(withFood: true)
        sut.move()
        sut.turn(.left)
        sut.move()
        sut.turn(.left)
        sut.move()
        sut.turn(.left)
        sut.move()
        XCTAssertTrue(sut.isTouchingSelf())
    }
}
