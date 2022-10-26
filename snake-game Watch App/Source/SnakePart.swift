import SpriteKit

class SnakePart: SKSpriteNode {
    
    init(imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        let size = CGSize(width: 15, height: 15)
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
