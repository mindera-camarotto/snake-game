import SwiftUI
import SpriteKit

struct ContentView: View {
    let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    @State var scrollAmount = 0.0
    @State var currentScrollAmount = 0.0
    
    var body: some View {
        SpriteView(scene: scene)
            .onTapGesture(perform: {
                scene.tapped()
            })
            .focusable()
            .digitalCrownRotation($scrollAmount)
            .onChange(of: scrollAmount) { newValue in
                if newValue > currentScrollAmount {
                    scene.turn(.left)
                } else {
                    scene.turn(.right)
                }
                self.currentScrollAmount = newValue
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
