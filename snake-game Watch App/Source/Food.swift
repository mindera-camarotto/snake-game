import SpriteKit

class Food: SKSpriteNode {
    let coordinate: Coordinate
    
    init(coordinate: Coordinate) {
        self.coordinate = coordinate
        
        let texture = SKTexture(imageNamed: "dk-food")
        let size = CGSize(width: Constants.gridMultiplier, height: Constants.gridMultiplier)
        super.init(texture: texture, color: .clear, size: size)
        
        position = CGPoint(x: coordinate.x * Constants.gridMultiplier, y: coordinate.y * Constants.gridMultiplier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
