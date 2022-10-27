import SpriteKit

class SnakePart: SKSpriteNode {
    
    init(imageName: String, letter: String?) {
        let texture = SKTexture(imageNamed: imageName)
        let size = CGSize(width: Constants.gridMultiplier, height: Constants.gridMultiplier)
        super.init(texture: texture, color: .clear, size: size)
     
        if let letter {
            let letterChild = SKSpriteNode(imageNamed: letter)
            letterChild.size = CGSize(width: Constants.gridMultiplier / 3, height: Constants.gridMultiplier / 3)
            addChild(letterChild)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
