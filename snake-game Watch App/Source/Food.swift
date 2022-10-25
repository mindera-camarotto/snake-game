import SpriteKit

class Food: SKSpriteNode {
    private let imageName = "food"
    var eaten = false {
        didSet {
            if eaten {
                run(SKAction.fadeOut(withDuration: 0.8)) { [weak self] in
                    self?.removeFromParent()
                }
            }
        }
    }
    
    init() {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: texture.size())
        size = CGSize(width: 15, height: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
