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
    
    func isCorner() -> Bool {
        let a = [Direction.west, Direction.east]
        let b = [Direction.north, Direction.south]
        
        guard let next = directionNext, let previous = directionPrevious else {
            return false
        }
        
        return (a.contains(next) && b.contains(previous))
        || (a.contains(previous) && b.contains(next))
    }
}
