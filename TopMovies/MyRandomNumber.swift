import Foundation

class MyRandomNumber {

    var xRandom: XRandom!

    func getNumber() -> Int {
        return xRandom.get()
    }
}

class XRandom {
    func get() -> Int {
        return Int.random(in: 0...10)
    }
}
