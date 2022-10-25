import SpriteKit

class SnakeTail: SKSpriteNode {
    var movingDirection: Direction = .up
    private let imageName = "tail"
    private let moveActionName = "move-tail"
    
    private var directionChanges = [DirectionChange]()
    
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

extension SnakeTail: SnakePart {
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
        let directionChange = DirectionChange(position: position, direction: direction)
        directionChanges.append(directionChange)
    }
}

extension SnakeTail: HeadFollower {
    func checkIfNeedsChangingDirection() {
        guard let change = directionChanges.first else { return }
        
        let snakeX = Int(position.x)
        let positionX = Int(change.position.x)
        let snakeY = Int(position.y)
        let positionY = Int(change.position.y)
        
        if snakeX == positionX, snakeY == positionY {
            position.x = change.position.x
            position.y = change.position.y
            directionChanges.removeFirst()
            changeDirection(change.direction)
        }
    }
}

extension SnakeTail: BodyCreator {
    func addNewBody(_ body: SnakeBody) {
        let newPositionAction: SKAction
        body.position = position
        
        switch movingDirection {
        case .up:
            newPositionAction = SKAction.moveBy(x: 0, y: -25, duration: 0.3)
        case .down:
            newPositionAction = SKAction.moveBy(x: 0, y: 25, duration: 0.3)
        case .right:
            newPositionAction = SKAction.moveBy(x: -25, y: 0, duration: 0.3)
        case .left:
            newPositionAction = SKAction.moveBy(x: 25, y: 0, duration: 0.3)
        }
        
        directionChanges.forEach { change in
            body.directionChanged(change.direction, at: change.position)
        }
        
        body.movingDirection = movingDirection
        body.move()
        body.run(.fadeIn(withDuration: 0.3))
        run(newPositionAction)
    }
}
