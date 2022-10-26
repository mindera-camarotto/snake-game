import SpriteKit

class GameScene: SKScene {
    
    private let snake = Snake()
    
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
        
        snake.position = CGPoint(x: frame.midX, y: frame.midY)
        snake.size = CGSize(width: 100, height: 40)
        
        addChild(background)
        addChild(snake)
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkIfSnakeTouchesBorder()
        
        switch snake.state {
        case .idle:
            break
        case .moving:
            snake.move()
        case .dead:
            print("game over")
        }
    }
    
    private func checkIfSnakeTouchesBorder() {
        switch snake.movingDirection {
        case .north:
            if snake.frame.maxY >= frame.maxY { snake.state = .idle }
            else { snake.state = .moving }
        case .south:
            if snake.frame.minY <= frame.minY { snake.state = .idle }
            else { snake.state = .moving }
        case .east:
            if snake.frame.maxX >= frame.maxX { snake.state = .idle }
            else { snake.state = .moving }
        case .west:
            if snake.frame.minX <= frame.minY { snake.state = .idle }
            else { snake.state = .moving }
        }
    }
    
    func didSwipe(direction: Direction) {
        snake.movingDirection = direction
    }
    
}
