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
        return pow(x, 4.0)
    }
    public func functionDiff(x: Double) -> Double {
        return 4.0 * pow(x, 3.0)
    }
    public func overallError(value: Double) -> Double {
        return functionDiff(x: x0) - value
    }
}



