import SpriteKit

class Food: SKSpriteNode {
    let coordinate: Coordinate
    
    init(coordinate: Coordinate) {
        self.coordinate = coordinate
        
        let texture = SKTexture(imageNamed: "dk-food")
        let size = CGSize(width: 15, height: 15)
        super.init(texture: texture, color: .clear, size: size)
        
        position = CGPoint(x: coordinate.x * 15, y: coordinate.y * 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
