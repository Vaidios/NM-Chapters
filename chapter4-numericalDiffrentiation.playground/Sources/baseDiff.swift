import Foundation

public class NumericalDiffrentiation {
    public let x0: Double
    public let h:  Double
    public let n: Int
    public init(x0: Double, h: Double, n: Int) {
        self.x0 = x0
        self.h = h
        self.n = n
    }
    public func function(x: Double) -> Double {
        return 1/x
    }
    public func functionDiff(x: Double) -> Double {
        return -1 / pow(x, 2)
    }
    public func overallError(value: Double) -> Double {
        return functionDiff(x: x0) - value
    }
}



