import SwiftUI
import SpriteKit

struct ContentView: View {
    let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if isSwipping {
                    startPos = gesture.location
                    isSwipping.toggle()
                }
            }
            .onEnded { gesture in
                let xDist = abs(gesture.location.x - startPos.x)
                let yDist = abs(gesture.location.y - startPos.y)
                if startPos.y <  gesture.location.y, yDist > xDist {
                    scene.didSwipe(direction: .down)
                }
                else if startPos.y >  gesture.location.y, yDist > xDist {
                    scene.didSwipe(direction: .up)
                }
                else if startPos.x > gesture.location.x, yDist < xDist {
                    scene.didSwipe(direction: .left)
                }
                else if startPos.x < gesture.location.x, yDist < xDist {
                    scene.didSwipe(direction: .right)
                }
                isSwipping.toggle()
            }
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .gesture(drag)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
