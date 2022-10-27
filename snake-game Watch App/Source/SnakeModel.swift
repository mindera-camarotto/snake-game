import Foundation

class SnakeModel {
    
    private let snakeRegister = ShiftRegister<SnakeElement>()
    private var currentDirection: Direction = .east
    private var pendingDirection: Direction? = nil
    
    var headPosition: Coordinate? {
        snakeRegister[0]?.position
    }
    
    var currentPositions: [Coordinate] {
        return snakeRegister.elements.map {element in element.position }
    }
    
    var length: Int {
        snakeRegister.count
    }
    
    init() {
        snakeRegister.count = 3
        snakeRegister.push(SnakeElement(position: Coordinate(x: 0, y: 5), hasFood: false, directionNext: .east, directionPrevious: nil))
        snakeRegister.push(SnakeElement(position: Coordinate(x: 1, y: 5), hasFood: false, directionNext: .east, directionPrevious: .west))
        snakeRegister.push(SnakeElement(position: Coordinate(x: 2, y: 5), hasFood: false, directionNext: nil, directionPrevious: .west))
    }
    
    func turn(_ turn: Turn) {
        switch (turn, currentDirection) {
        case (.left, .north):
            pendingDirection = .west
        case (.left, .east):
            pendingDirection = .north
        case (.left, .south):
            pendingDirection = .east
        case (.left, .west):
            pendingDirection = .south
        case (.right, .north):
            pendingDirection = .east
        case (.right, .west):
            pendingDirection = .north
        case (.right, .south):
            pendingDirection = .west
        case (.right, .east):
            pendingDirection = .south
        }
    }
    
    func eatFood() {
        snakeRegister[0]?.hasFood = true
    }
    
    func move() {
        if let pendingDirection = pendingDirection {
            currentDirection = pendingDirection
            self.pendingDirection = nil
        }
        let currentHeadPosition = snakeRegister[0]!.position
        
        let backDirection: Direction
        let newHeadPosition: Coordinate
        switch currentDirection {
        case .north:
            newHeadPosition = Coordinate(x: currentHeadPosition.x, y: currentHeadPosition.y + 1)
            backDirection = .south
        case .west:
            newHeadPosition = Coordinate(x: currentHeadPosition.x - 1, y: currentHeadPosition.y)
            backDirection = .east
        case .east:
            newHeadPosition = Coordinate(x: currentHeadPosition.x + 1, y: currentHeadPosition.y)
            backDirection = .west
        case .south:
            newHeadPosition = Coordinate(x: currentHeadPosition.x, y: currentHeadPosition.y - 1)
            backDirection = .north
        }
        let newElement = SnakeElement(position: newHeadPosition, hasFood: false, directionNext: nil, directionPrevious: backDirection)
        
        //Check if tail has food and increment length if so
        let currentTail = snakeRegister[snakeRegister.count - 1]
        if currentTail?.hasFood == true {
            currentTail?.hasFood = false
            snakeRegister.count += 1
        }
        
        //Set front direction of current head to new head
        let currentHead = snakeRegister[0]
        currentHead?.directionNext = currentDirection
        
        snakeRegister.push(newElement)
        
        //Set previous direction of new tail to nil
        let newTail = snakeRegister[snakeRegister.count - 1]
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
