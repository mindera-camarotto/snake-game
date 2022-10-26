import SpriteKit

class GameScene: SKScene {
    
    var model = SnakeModel()
    var lastUpdate = 0.0

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
            print("going to do a move")
            // move snake
            model.move()
            removeAllChildren()
            renderSnake()
            lastUpdate = currentTime
        }
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
        let snake = Snake()
        snake.position = CGPoint(x: item.position.x * 20, y: item.position.y * 20)
        snake.size = CGSize(width: 10, height: 10)
        return snake
    }
    
}
