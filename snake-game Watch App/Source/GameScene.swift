import SpriteKit

class GameScene: SKScene {
    
    var model = SnakeModel()
    var lastUpdate = 0.0
    
    let _90: CGFloat = .pi / 2
    let _180: CGFloat = .pi
    let _270: CGFloat = .pi / -2

    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setUpSprites() {
//        let background = SKSpriteNode(imageNamed: "background")
//        background.size = frame.size
//        background.position = CGPoint(x: frame.midX, y: frame.midY)
////
////        snake.position = CGPoint(x: frame.midX, y: frame.midY)
////        snake.size = CGSize(width: 100, height: 40)
//        
////        addChild(background)
////        addChild(snake)
//    }
    
    override func update(_ currentTime: TimeInterval) {
        let delta = currentTime - lastUpdate
        if (delta > 0.6) {
            // move snake
            model.move(withFood: true)
            removeAllChildren()
            renderSnake()
            lastUpdate = currentTime
        }
    }
    
    func turn(_ turn: Turn) {
        model.turn(turn)
    }
    
    private func renderSnake() {
        for i in 0..<model.getLength() {
            if let segment = model[i] {
                let child = spawnChild(segment)
                addChild(child)
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
