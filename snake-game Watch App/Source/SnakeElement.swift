import Foundation

struct SnakeElement {
    let position: Coordinate
    var hasFood: Bool
    var directionNext: Direction?
    var directionPrevious: Direction?
}
