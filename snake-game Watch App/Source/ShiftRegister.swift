import Foundation

class ShiftRegister<T> {
    private (set) var elements: [T] = []
    var count: Int = 0 {
        didSet {
            removeExcessElements()
        }
    }
    
    func push(_ element: T) {
        elements.insert(element, at: 0)
        removeExcessElements()
    }
    
    private func removeExcessElements() {
        let numberToRemove = elements.count - count
        if numberToRemove > 0 {
            elements.removeLast(numberToRemove)
        }
    }
    
    subscript(index: Int) -> T? {
        return index < elements.count ? elements[index] : nil
    }
}
