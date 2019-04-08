
import Foundation

public struct lagrangeWithChebyshew {
    
    var X: [Double] = []
    var Y: [Double] = []
    var degree: Int = 0
    var x: Double = 0
    var precision: Double = 0
    var result: Double = 0
    public init() {
        
    }
    public mutating func initialize(lBound: Double, uBound: Double, x: Double, precision: Double, degree: Int) {
        self.degree = degree
        chebyshewInterval(lBound: lBound, uBound: uBound)
        getValuesInInterval()
        self.x = x
        self.precision = precision
        result = calculateLangrange()
        print("[CHAVEBSKY SPACED NODES]")
        print("Calculated value in lagrange polynomial with chavesky spaced nodes is \(result)")
        print("Calculated maximal error in this polynomial at given interval \(X.first!) and \(X.last!) with precision of \(precision) is \(calculateError())\n\n")
    }
    public func printResults() {
        
    }
    private func calculateLangrange() -> Double {
        var result: Double = 0
        for i in 0 ..< X.count {
            result = result + Wi(x: x, node: X[i]) * Y[i]
        }
        return result
    }
    private func calculateLangrange(step: Double) -> Double {
        var result: Double = 0
        for i in 0 ..< X.count {
            result = result + Wi(x: step, node: X[i]) * Y[i]
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
    
    mutating private func chebyshewInterval(lBound: Double, uBound: Double) {
        //number of nodes is n+1 degree of polynomial
        let numberOfNodes = degree
        let pi = Double.pi
        //For formula 3.57
        for node in 0...numberOfNodes {
            let node = Double(node)
            let nominator = (2 * node + 1) * pi
            let denominator: Double = 2.0 * Double(numberOfNodes) + 2.0
            let calculatedNode = cos(nominator/denominator)
            X.append(calculatedNode)
        }
        var Zi: [Double] = []
        for node in 0...numberOfNodes {
            let node = Double(node)
            let calculatedNode = (1.0/2.0)*((uBound - lBound) * X[Int(node)] + lBound + uBound)
            Zi.append(calculatedNode)
        }
        X = Zi.reversed()
    }
    mutating private func getValuesInInterval() {
        for arg in X {
            Y.append(function(arg))
        }
    }
    private func function(_ x: Double) -> Double {
        return pow(x, 4)
    }
    
    func calculateError() -> Double{
        var errorValues: [Double] = []
        for step in stride(from: X.first!, to: X.last!, by: precision) {
            errorValues.append(abs(function(step) - calculateLangrange(step: step)))
        }
        guard let maxError = errorValues.max() else {
            print("[ERROR] Maximum value wasn't found")
            return 0
        }
        return maxError
    }
}
