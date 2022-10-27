import Foundation

enum Difficulty : Double {
    case easy = 0.6
    case medium  = 0.4
    case hard  = 0.3
    case crazy  = 0.2
    
    func getTick(_ eatenFood: Int) -> Double {
        // lowest you could ever be is 0.1
        max(rawValue * pow(0.98, Double(eatenFood)), 0.1)
    }
}
