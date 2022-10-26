import Foundation

struct SnakeElement {
    let position: Coordinate
    var hasFood: Bool
    var directionFront: Direction? = nil
    var directionBack: Direction?
}
