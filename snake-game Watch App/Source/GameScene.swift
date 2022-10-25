import SpriteKit

class GameScene: SKScene {
    
    private let snake = Snake()
    private var food = Food()
    
    override init(size: CGSize) {
        super.init(size: size)
        setUpSprites()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSprites() {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        
        food.position = CGPoint(x: frame.midX + 40, y: frame.midY - 75)
        food.name = "food"
        
        addChild(background)
        addChild(food)
        snake.sceneDelegate = self
        snake.present(to: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake.update(currentTime)
        
        snake.checkCollision(food: food)
        
//        snake.checkIfTouchesBorder(with: frame)
        
//        switch snake.state {
//        case .idle:
//            break
//        case .moving:
//            snake.move()
//        case .dead:
//            print("game over")
//        }
    }
    
    func didSwipe(direction: Direction) {
        snake.changeDirection(direction)
    }
    
}

extension GameScene: GameSceneDelegate {
    func spawnFood() {
        food = Food()
        
        let maxX = Int(frame.maxX) - 15
        let maxY = Int(frame.maxY) - 15
        
        let randomX = Int.random(in: 15...maxX)
        let randomY = Int.random(in: 15...maxY)
        
        food.position = CGPoint(x: randomX, y: randomY)
        addChild(food)
    }
}
