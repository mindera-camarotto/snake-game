import SpriteKit

class SnakeHead: SKSpriteNode {
    var movingDirection: Direction = .up
    private let imageName = "head"
    private let moveActionName = "move-head"
    
    init() {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func changeDirection(_ direction: Direction) {
        movingDirection = direction
        let action: SKAction
        
        switch movingDirection {
        case .up:
            action = SKAction.rotate(toAngle: 0, duration: 0.2, shortestUnitArc: true)
        case .down:
            action = SKAction.rotate(toAngle: .pi, duration: 0.2, shortestUnitArc: true)
        case .right:
            action = SKAction.rotate(toAngle: -.pi / 2, duration: 0.2, shortestUnitArc: true)
        case .left:
            action = SKAction.rotate(toAngle: .pi / 2, duration: 0.2, shortestUnitArc: true)
        }
        
        run(action)
        move()
    }
}

extension SnakeHead: SnakePart {
    func move() {
        removeAction(forKey: moveActionName)
        let action: SKAction
        
        switch movingDirection {
        case .up:
            action = SKAction.moveBy(x: 0, y: velocity, duration: 0.5)
        case .down:
            action = SKAction.moveBy(x: 0, y: -velocity, duration: 0.5)
        case .right:
            action = SKAction.moveBy(x: velocity, y: 0, duration: 0.5)
        case .left:
            action = SKAction.moveBy(x: -velocity, y: 0, duration: 0.5)
        }
        
        
        run(SKAction.repeatForever(action),
            withKey: moveActionName)
    }
    
    func directionChanged(_ direction: Direction, at position: CGPoint) {
        changeDirection(direction)
    }
}
