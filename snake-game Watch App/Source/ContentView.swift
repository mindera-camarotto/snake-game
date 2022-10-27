import SwiftUI
import SpriteKit
import Combine

struct ContentView: View {
    let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    @State var scrollAmount = 0.0
    @State var currentScrollAmount = 0.0
    
    var body: some View {
        SpriteView(scene: scene)
            .onTapGesture(perform: { tap in
                scene.tapped(CGPoint(x: tap.x, y: tap.y))
            })
            .focusable()
            .digitalCrownRotation($scrollAmount, from: -1, through: 1, sensitivity: .low)
//            .digitalCrownRotation($scrollAmount, sensitivity: .medium)
            .onChange(of: scrollAmount) { newValue in
                if newValue > currentScrollAmount {
                    print(newValue)
                    scene.turn(.left)
//                    scene.turn = .left
                } else {
                    print(newValue)
                    scene.turn(.right)
//                    scene.turn = .right
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
