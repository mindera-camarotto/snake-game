import SwiftUI
import SpriteKit

struct ContentView: View {
    let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    @State var scrollAmount = 0.0
    
    var body: some View {
        SpriteView(scene: scene)
        //            .digitalCrownRotation($scrollAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
