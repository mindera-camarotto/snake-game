import SpriteKit

enum SnakeState {
    case idle
    case moving
    case dead
}

class Snake: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "snake.png")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() {
//        switch movingDirection {
//        case .north:
//            position = CGPoint(x: position.x, y: position.y + velocity)
//        case .south:
//            position = CGPoint(x: position.x, y: position.y - velocity)
//        case .east:
//            position = CGPoint(x: position.x + velocity, y: position.y)
//        case .west:
//            position = CGPoint(x: position.x - velocity, y: position.y)
//        }
    }
}
