import Foundation

class SnakeModel {
    
    private let snakeRegister = ShiftRegister<SnakeElement>()
    private var currentDirection: Direction = .right
    
    init() {
        snakeRegister.count = 3
        snakeRegister.push(SnakeElement(position: Coordinate(x: 3, y: 3), hasFood: false, directionFront: .right, directionBack: nil))
        snakeRegister.push(SnakeElement(position: Coordinate(x: 4, y: 3), hasFood: false, directionFront: .right, directionBack: .left))
        snakeRegister.push(SnakeElement(position: Coordinate(x: 5, y: 3), hasFood: false, directionFront: nil, directionBack: .left))
    }
    
    func getLength() -> Int {
        return snakeRegister.count
    }
    
    func setDirection(_ direction: Direction) {
        currentDirection = direction
    }
    
    func move(withFood: Bool) {
        let currentHeadPosition = snakeRegister[0]?.position ?? Coordinate(x: 0, y: 0)
        
        let backDirection: Direction
        let newHeadPosition: Coordinate
        switch currentDirection {
        case .up:
            newHeadPosition = Coordinate(x: currentHeadPosition.x, y: currentHeadPosition.y + 1)
            backDirection = .down
        case .left:
            newHeadPosition = Coordinate(x: currentHeadPosition.x - 1, y: currentHeadPosition.y)
            backDirection = .right
        case .right:
            newHeadPosition = Coordinate(x: currentHeadPosition.x + 1, y: currentHeadPosition.y)
            backDirection = .left
        case .down:
            newHeadPosition = Coordinate(x: currentHeadPosition.x, y: currentHeadPosition.y - 1)
            backDirection = .up
        }
        let newElement = SnakeElement(position: newHeadPosition, hasFood: withFood, directionNext: nil, directionPrevious: backDirection)
        
        //Check if tail has food and increment length if so
        var currentTail = snakeRegister[snakeRegister.count - 1]
        if currentTail?.hasFood == true {
            currentTail?.hasFood = false
            snakeRegister.count += 1
        }
        
        //Set front direction of current head to new head
        var currentHead = snakeRegister[0]
        currentHead?.directionNext = currentDirection
        
        snakeRegister.push(newElement)
        
        //Set previous direction of new tail to nil
        var newTail = snakeRegister[snakeRegister.count - 1]
        newTail?.directionPrevious = nil
    }
    
    func isTouchingSelf() -> Bool {
        let currentHead = snakeRegister[0]
        for n in 1...snakeRegister.count - 1 {
            if currentHead?.position == snakeRegister[n]?.position {
                return true
            }
        }
        return false
    }
    
    subscript(index: Int) -> SnakeElement? {
        return snakeRegister[index]
    }
}
