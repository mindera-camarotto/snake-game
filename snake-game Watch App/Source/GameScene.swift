import SpriteKit
import Combine

typealias Callback = () -> Void

class GameScene: SKScene {

    var snakeParts = [SKSpriteNode]()
    var model = SnakeModel()
    var postMove : [Callback] = []
    var foodEaten = 0
    var difficulty : Difficulty = .medium
    
    var food: Food?
    
    var lastUpdate = 0.0
    var status = GameStatus.newGame
    var lastGameOver: Double?
    
    let _90: CGFloat = .pi / 2
    let _180: CGFloat = .pi
    let _270: CGFloat = .pi / -2
    let letters: [String?] = [nil, "F", "A", "N", "D", "U", "E", "L"]
    private var maxX: Int {
        get {
            let multiplier = difficulty.getGridMultiplier()
            let space = Int(frame.maxX) - (multiplier / 2)
            return space / multiplier
        }
    }
    private var maxY: Int {
        get {
            let multiplier = difficulty.getGridMultiplier()
            let space = Int(frame.maxY) - (multiplier / 2)
            return space / multiplier
        }
    }
    
    private func newGame() {
        removeAllChildren()
        spawnFood()
        foodEaten = 0
        model = SnakeModel()
        status = .playing
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch status {
        case .newGame:
            if checkNewGame(currentTime: currentTime) {
                newGame()
            }
        case .playing:
            runPlaying(currentTime: currentTime)
            
        case .pause:
            break
            
        case .dead:
            lastGameOver = currentTime
            presentGameOver()
            
        case .gameOverPresented:
            break
        }
    }
    
    private func runPlaying(currentTime: TimeInterval) {
        let delta = currentTime - lastUpdate
        if delta > difficulty.getTick(foodEaten) {
            model.move()
            postMove.forEach { $0() }
            postMove = []
            
            if let foodPosition = food?.coordinate, model.headPosition == foodPosition {
                let lockedInFood = food
                postMove.append() {
                    lockedInFood?.removeFromParent()
                }
                model.eatFood()
                spawnFood()
            }
            
            snakeParts.forEach { node in
                node.removeFromParent()
            }
            snakeParts = []
            renderSnake()
            lastUpdate = currentTime
            
            status = model.isTouchingSelf() ? .dead : .playing
            if let head = model.headPosition,
               head.x > maxX || head.x <= 0 || head.y > maxY || head.y <= 0 {
                status = .dead
            }
            
        }
    }
    
    private func presentGameOver() {
        let label = SKLabelNode(text: "Game Over!")
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        label.fontSize = 26
        addChild(label)
        
        let label2 = SKLabelNode(text: "DKs Eaten: \(foodEaten)")
        label2.position = CGPoint(x: frame.midX, y: frame.midY - 26)
        label2.fontSize = 26
        addChild(label2)
        
        status = .gameOverPresented
    }
    
    func turn(_ turn: Turn, postMove: @escaping Callback) {
        model.turn(turn)
        self.postMove.append(postMove)
    }
    
    func tapped(_ position: CGPoint) {
        switch status {
        case .gameOverPresented:
            status = .newGame
        case .playing:
            turn(position.x < frame.midX ? .left : .right) {}
        default:
            break
        }
    }
    
    private func renderSnake() {
        for i in 0..<model.length {
            var letterChosen : String?
            if i != 0, i != model.length - 1 {
                letterChosen = letters[i % 8]
            }
            if let segment = model[i] {
                let child = spawnChild(segment, letter: letterChosen)
                addChild(child)
                snakeParts.append(child)
            }
        }
    }
    
    private func spawnChild(_ item: SnakeElement, letter: String?) -> SKSpriteNode {
        var snakeImage: String
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

        if (item.hasFood) { snakeImage += "_food" }
        let snake = SnakePart(imageName: snakeImage, size: difficulty.getGridMultiplier(), letter: letter)
        let x = item.position.x * difficulty.getGridMultiplier()
        let y = item.position.y * difficulty.getGridMultiplier()
        snake.position = CGPoint(x: x, y: y)
        snake.zRotation = rotation
        return snake
    }
    
    func spawnFood() {
        var newFoodCoord : Coordinate
        repeat {
            let randomX = Int.random(in: 1...maxX)
            let randomY = Int.random(in: 1...maxY)
            newFoodCoord = Coordinate(x: randomX, y: randomY)
        } while model.currentPositions.contains(newFoodCoord)
        
        let newFood = Food(coordinate: newFoodCoord, size: difficulty.getGridMultiplier())
        food = newFood
        foodEaten += 1
        addChild(newFood)
    }
    
    private func checkNewGame(currentTime: TimeInterval) -> Bool {
        guard let lastGameOver else { return true }
        
        let delta = currentTime - lastGameOver
        if delta > 2.5 {
            self.lastGameOver = nil
            return true
        }
        return false
    }
}
