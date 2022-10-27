import SwiftUI
import SpriteKit
import Combine


enum Difficulty : Double {
    case easy = 0.6
    case medium  = 0.4
    case hard  = 0.3
    case crazy  = 0.2
}

struct ContentView: View {
    
    @State var startPos : CGPoint = .zero
    @State var isSwipping = true
    @State var scrollAmount = 1.0
    @State var currentScrollAmount = 1.0
    @State var difficulty : Difficulty?
    
    let scene = GameScene(size: WKInterfaceDevice.current().screenBounds.size)
    
    var body: some View {
        if difficulty == nil {
            VStack {
                Text("Select Difficulty")
                    .padding(.bottom)
                HStack {
                    Button( "easy") {
                        difficulty = .easy
                        scene.difficulty = difficulty!
                    }
                    Button( "medium") {
                        difficulty = .medium
                        scene.difficulty = difficulty!
                    }
                }
                HStack {
                    Button( "hard") {
                        difficulty = .hard
                        scene.difficulty = difficulty!
                    }
                    Button( "crazy") {
                        difficulty = .crazy
                        scene.difficulty = difficulty!
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
                        print("ask to turn left")
                        scene.turn(.left) {
                            //                        scrollAmount = 1
                            print("attempting to set scrollAmount to 1")
                        }
                    } else {
                        print("ask to turn right")
                        scene.turn(.right) {
                            //                        scrollAmount = 1
                            print("attempting to set scrollAmount to 1")
                        }
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
