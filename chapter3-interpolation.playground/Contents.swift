import Foundation

class Interpolation {
    
}

public struct LagrangePolynomialCalculator {
    var X: [Double] = []
    var Y: [Double] = []
    var nodeCount: Int = 0
    var x: Double = 0
    var precision: Double = 0
    public init(lowerBound: Double, upperBound: Double, degree: Int, x: Double, precision: Double) {
        X = equallySpacedInterval(lower: lowerBound, upper: upperBound, degree: degree)
        Y = getValuesInInterval(interval: X)
        nodeCount = X.count
        self.x = x
        self.precision = precision
    }
    public mutating func initialize(lBound: Double, uBound: Double, x: Double, precision: Double, degree: Int) {
        X = equallySpacedInterval(lower: lBound, upper: uBound, degree: degree)
        Y = getValuesInInterval(interval: X)
        nodeCount = degree + 1
        self.x = x
        self.precision = precision
        let y = calculatePolynomial(for: x)
        print("[EVENLY SPACED NODES]")
        print("Calculated value from lagrange polynomial is \(y), real value is \(function(x))")
        print("Calculated maximal error in this polynomial at given interval \(X.first!) and \(X.last!) with precision of \(precision) is \(calculateError(precision: precision))\n\n")
    }
    public func calculatePolynomial(for x: Double) -> Double {
        var result: Double = 0
        for i in 0 ..< nodeCount {
            result = result + Wi(x: x, node: X[i]) * Y[i]
        }
        return result
    }
    
    private func Wi(x: Double, node: Double) -> Double {
        let nodeCount = X.count
        var numerator: Double = 1
        var denominator: Double = 1
        for j in 0 ..< nodeCount {
            if (node - X[j]) == 0 {
                continue
            }
            numerator *= x - X[j]
            denominator *= node - X[j]
        }
        return numerator / denominator
    }
    
    private func equallySpacedInterval(lower lBound: Double, upper uBound: Double, degree: Int) -> [Double] {
        var returnArray: [Double] = []
        if degree == 0 {
            print("[ERROR]Number of nodes can't be equal to \(degree) in lagrange Polynomial, returning empty array")
            return []
        }
        let distance = abs(lBound - uBound)/Double(degree)
        for i in 0 ... degree {
            let spacedNode = lBound + (Double(i) * distance)
            returnArray.append(spacedNode)
        }
        return returnArray
    }
    private func getValuesInInterval(interval: [Double]) -> [Double] {
        var returnArray: [Double] = []
        for arg in interval {
            returnArray.append(function(arg))
        }
        return returnArray
    }
    mutating private func getValuesInInterval() {
        for arg in X {
            Y.append(function(arg))
        }
    }
    func function(_ arg: Double) -> Double {
        return pow(arg, 4)
    }
    func calculateError(precision: Double) -> Double{
        var errorValues: [Double] = []
        var argArr = [Double]()
        print("X.first \(X.first!)  X.last \(X.last!)")
        for step in stride(from: X.first!, through: X.last!, by: precision) {
            argArr.append(step)
            errorValues.append(abs(function(step) - calculatePolynomial(for: step)))
        }
        guard let maxError = errorValues.max() else {
            print("Maximum error wasn't found")
            return 0
        }
        if let indexAtMax = errorValues.firstIndex(of: maxError) {
            let arg = argArr[indexAtMax]
            print("Argument X: \(arg), and f(x)=\(function(arg))")
        }
        
        return maxError
    }
}
//
var lagCalc = LagrangePolynomialCalculator(lowerBound: -10, upperBound: 10, degree: 4, x: 1.5, precision: 0.1)
lagCalc.initialize(lBound: -10, uBound: 10, x: 1.5, precision: 0.1, degree: 24)
//lagCalc.printAllAbout()
//let y = lagCalc.calculatePolynomial(for: 1.5)


var chavebsky = lagrangeWithChebyshew()
chavebsky.initialize(lBound: -10, uBound: 10, x: 1.5, precision: 0.1, degree: 24)
print(2+2)
