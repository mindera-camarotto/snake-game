import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @State var scrollAmount = 1.0
    @State var currentScrollAmount = 1.0
    @State var difficulty : Difficulty? {
        didSet {
            guard let difficulty else { return }
            scene.difficulty = difficulty
        }
    }
    
    let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    var body: some View {
        if difficulty == nil {
            VStack {
                Text("Select Difficulty")
                    .padding(.bottom)
                HStack {
                    Button( "easy") {
                        difficulty = .easy
                    }
                    Button( "medium") {
                        difficulty = .medium
                    }
                }
                HStack {
                    Button( "hard") {
                        difficulty = .hard
                    }
                    Button( "crazy") {
                        difficulty = .crazy
                    }
                }
            }
        } else {
            SpriteView(scene: scene)
                .onTapGesture(perform: { tap in
                    scene.tapped(CGPoint(x: tap.x, y: tap.y))
                })
                .focusable()
                .digitalCrownRotation($scrollAmount)
                .onChange(of: scrollAmount, perform: { newValue in
                    print(newValue)
                    if newValue > currentScrollAmount {
                        scene.turn(.left) { }
                    } else {
                        scene.turn(.right) { }
                    }
                    self.currentScrollAmount = newValue
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
