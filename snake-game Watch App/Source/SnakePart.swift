import SpriteKit

class SnakePart: SKSpriteNode {
    
    init(imageName: String, size: Int, letter: String?) {
        let texture = SKTexture(imageNamed: imageName)
        let imgSize = CGSize(width: size, height: size)
        super.init(texture: texture, color: .clear, size: imgSize)
     
        if let letter {
            let letterChild = SKSpriteNode(imageNamed: letter)
            letterChild.size = CGSize(width: size / 3, height: size / 3)
            addChild(letterChild)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
