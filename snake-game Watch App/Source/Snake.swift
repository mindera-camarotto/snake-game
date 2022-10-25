import SpriteKit

enum SnakeState {
    case idle
    case moving
    case dead
}

struct Coordinate {
    let x: Int
    let y: Int
}

struct SnakeElement {
    let position: Coordinate
    let hasFood: Bool
    var directionFront: Direction? = nil
    var directionBack: Direction?
}

class Snake: SKSpriteNode {
    
    var state: SnakeState = .moving
    var movingDirection: Direction = .right
    
    private let imageName = "snake.png"
    private let velocity: CGFloat = 1
    
    init() {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() {
        switch movingDirection {
        case .up:
            position = CGPoint(x: position.x, y: position.y + velocity)
        case .down:
            position = CGPoint(x: position.x, y: position.y - velocity)
        case .right:
            position = CGPoint(x: position.x + velocity, y: position.y)
        case .left:
            position = CGPoint(x: position.x - velocity, y: position.y)
        }
    }
}
