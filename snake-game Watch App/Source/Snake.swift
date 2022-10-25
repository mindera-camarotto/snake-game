import SpriteKit

enum SnakeState {
    case idle
    case moving
    case dead
}

struct DirectionChange {
    let position: CGPoint
    let direction: Direction
}

protocol SnakePart {
    var movingDirection: Direction { get }
    var velocity: CGFloat { get }
    func move()
    func directionChanged(_ direction: Direction, at position: CGPoint)
}

extension SnakePart {
    var velocity: CGFloat {
        20
    }
}

protocol BodyCreator {
    func addNewBody(_ body: SnakeBody)
}

protocol HeadFollower {
    func directionChanged(_ direction: Direction, at position: CGPoint)
    func checkIfNeedsChangingDirection()
}

protocol GameSceneDelegate {
    func spawnFood()
}

extension CGFloat {
    static func -(lhs: CGFloat, rhs: Int) -> CGFloat {
        lhs - CGFloat(rhs)
    }
}

class Snake: SKSpriteNode {
    
    var state: SnakeState = .moving
    var head = SnakeHead()
    var tail = SnakeTail()
    var parentScene: SKScene?
    var bodyList = [SnakeBody]()
    var sceneDelegate: GameSceneDelegate?
    
    private let frameSize = 25
    
    func present(to scene: SKScene) {
        head.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        head.size = CGSize(width: frameSize, height: frameSize)
        head.name = "head"
        
        tail.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY - frameSize)
        tail.size = CGSize(width: frameSize, height: frameSize)
        
        parentScene = scene
        parentScene?.addChild(head)
        parentScene?.addChild(tail)
        
        head.move()
        tail.move()
    }
    
    func checkIfTouchesBorder(with frame: CGRect) {
        let snakeFrame = head.frame
        switch head.movingDirection {
        case .up:
            if snakeFrame.maxY >= frame.maxY { state = .idle }
            else { state = .moving }
        case .down:
            if snakeFrame.minY <= frame.minY { state = .idle }
            else { state = .moving }
        case .right:
            if snakeFrame.maxX >= frame.maxX { state = .idle }
            else { state = .moving }
        case .left:
            if snakeFrame.minX <= frame.minY { state = .idle }
            else { state = .moving }
        }
    }
    
    func checkCollision(food: Food) {
        if food.frame.intersects(head.frame), !food.eaten {
            food.eaten = true
            let body = SnakeBody()
            parentScene?.addChild(body)
            bodyList.append(body)
            tail.addNewBody(body)
            
            sceneDelegate?.spawnFood()
        }
    }
    
    func changeDirection(_ direction: Direction) {
        head.directionChanged(direction, at: head.position)
        tail.directionChanged(direction, at: head.position)
        bodyList.forEach { body in
            body.directionChanged(direction, at: head.position)
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        tail.checkIfNeedsChangingDirection()
        bodyList.forEach { body in
            body.checkIfNeedsChangingDirection()
        }
    }
}
