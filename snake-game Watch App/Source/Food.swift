import SpriteKit

class Food: SKSpriteNode {
    let coordinate: Coordinate
    
    init(coordinate: Coordinate, size: Int) {
        self.coordinate = coordinate
        
        let texture = SKTexture(imageNamed: "dk-food")
        let imgSize = CGSize(width: size, height: size)
        super.init(texture: texture, color: .clear, size: imgSize)
        
        let x = coordinate.x * size
        let y = coordinate.y * size
        
        position = CGPoint(x: x, y: y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
