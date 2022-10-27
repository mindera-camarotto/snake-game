import SwiftUI
import SpriteKit
import Combine


class A {
    static var allCallbacks : [() -> Void] = []
    
    static func addCallback ( callback: @escaping () -> Void) {
        allCallbacks.append(callback)
    }
    
    static func callback () {
        allCallbacks.forEach { cb in cb() }
    }
}


struct ContentView: View {
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    @State var scrollAmount = 1
    @State var currentScrollAmount = 1
    
    var scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    var body: some View {
        
        SpriteView(scene: scene)
            .onTapGesture(perform: { tap in
                scene.tapped(CGPoint(x: tap.x, y: tap.y))
            })
            .focusable()
            .digitalCrownRotation(detent: $scrollAmount, from: 0, through: 2, by: 1)
            .onChange(of: scrollAmount, perform: { newValue in
                print(newValue)
                if newValue == 1 {
                    return // don't rotate this change
                } else if newValue > currentScrollAmount {
                    print("ask to turn left")
                    scene.turn(.left) {
                        scrollAmount = 1
                        print("attempting to set scrollAmount to 1")
                    }
                } else {
                    print("ask to turn right")
                    scene.turn(.right) {
                        scrollAmount = 1
                        print("attempting to set scrollAmount to 1")
                    }
                }
                self.currentScrollAmount = newValue
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
