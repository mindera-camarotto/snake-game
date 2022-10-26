import SpriteKit

class GameScene: SKScene {
    
    var snakeParts = [SKSpriteNode]()
    var model = SnakeModel()
    
//    var food : SKSpriteNode;
    var foodLocation: Coordinate = Coordinate(x: 3, y: 3)
    
    var lastUpdate = 0.0
    var status = GameStatus.playing
    
    let _90: CGFloat = .pi / 2
    let _180: CGFloat = .pi
    let _270: CGFloat = .pi / -2

    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch status {
        case .newGame:
            removeAllChildren()
            model = SnakeModel()
            status = .playing
        case .playing:
            runPlaying(currentTime: currentTime)
        case .pause:
            // Not implemented
            break
        case .ended:
            runEnded()
        case .gameOverPresented:
            break
        }
    }
    
    private func runPlaying(currentTime: TimeInterval) {
        let delta = currentTime - lastUpdate
        if delta > 0.6 {
            model.move()
            if (model[0]?.position == foodLocation) {
//                model.iJustAteSomeFood()
            }
            snakeParts.forEach { node in
                node.removeFromParent()
            }
            snakeParts = []
            renderSnake()
            lastUpdate = currentTime
            
            status = model.isTouchingSelf() ? .ended : .playing
        }
    }
    
    private func runEnded() {
        let label = SKLabelNode(text: "Game Over! 🐍")
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        label.fontSize = 26
        addChild(label)
        status = .gameOverPresented
    }
    
    func turn(_ turn: Turn) {
        model.turn(turn)
    }
    
    func tapped() {
        if status == .gameOverPresented {
            status = .newGame
        }
    }
    
    private func renderSnake() {
        for i in 0..<model.getLength() {
            if let segment = model[i] {
                let child = spawnChild(segment)
                addChild(child)
                snakeParts.append(child)
            }
        }
    }
    
    private func spawnChild(_ item: SnakeElement) -> SKSpriteNode {
        let snakeImage: String
        let rotation: CGFloat
        if item.directionNext == nil {
            snakeImage = "head"
            switch item.directionPrevious! {
            case .north:
                rotation = _180
            case .south:
                rotation = 0.0
            case .east:
                rotation = _90
            case .west:
                rotation = _270
            }
        } else if item.directionPrevious == nil {
            snakeImage = "tail"
            switch item.directionNext! {
            case .north:
                rotation = _180
            case .south:
                rotation = 0.0
            case .east:
                rotation = _90
            case .west:
                rotation = _270
            }
        } else if item.isCorner() {
            snakeImage = "corner"
            switch (item.directionPrevious!, item.directionNext!) {
            case (.west, .north), (.north, .west):
                rotation = 0.0
            case (.west, .south), (.south, .west):
                rotation = _90
            case (.east, .north), (.north, .east):
                rotation = _270
            case (.east, .south), (.south, .east):
                rotation = _180
            default:
                rotation = 0.0
            }
        } else {
            snakeImage = "body"
            switch item.directionNext! {
            case .north, .south:
                rotation = _90
            case .east, .west:
                rotation = 0.0
            }
        }

        let snake = SnakePart(imageName: snakeImage)
        snake.position = CGPoint(x: item.position.x * 15, y: item.position.y * 15)
        snake.zRotation = rotation
        return snake
    }
    
}
