import SpriteKit

class GameScene: SKScene {
    
    var snakeParts = [SKSpriteNode]()
    var model = SnakeModel()
    
    var food: Food?
    
    var lastUpdate = 0.0
    var status = GameStatus.newGame
    
    let _90: CGFloat = .pi / 2
    let _180: CGFloat = .pi
    let _270: CGFloat = .pi / -2
    
    override func update(_ currentTime: TimeInterval) {
        switch status {
        case .newGame:
            removeAllChildren()
            spawnFood()
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
            
            if let foodPosition = food?.coordinate, model.headPosition == foodPosition {
                spawnFood()
                model.eatFood()
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
    
    func tapped(_ position: CGPoint) {
        switch status {
        case .gameOverPresented:
            status = .newGame
        case .playing:
            turn(position.x < frame.midX ? .left : .right)
        default:
            break
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
    
    func spawnFood() {
        food?.removeFromParent()
        
        let maxX = Int((frame.maxX - 8) / 15)
        let maxY = Int((frame.maxY - 8) / 15)
        var newFoodCoord : Coordinate
        
        repeat {
            let randomX = Int.random(in: 1...maxX)
            let randomY = Int.random(in: 1...maxY)
            newFoodCoord = Coordinate(x: randomX, y: randomY)
        } while model.currentPositions.contains(newFoodCoord)
        
        food = Food(coordinate: newFoodCoord)
        addChild(food!)
    }
}
