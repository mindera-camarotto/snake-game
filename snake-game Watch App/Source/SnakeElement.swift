import Foundation

class SnakeElement {
    let position: Coordinate
    var hasFood: Bool
    var directionNext: Direction?
    var directionPrevious: Direction?
    
    init(position: Coordinate, hasFood: Bool, directionNext: Direction? = nil, directionPrevious: Direction? = nil) {
        self.position = position
        self.hasFood = hasFood
        self.directionNext = directionNext
        self.directionPrevious = directionPrevious
    }
}
