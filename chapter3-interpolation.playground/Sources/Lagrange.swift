import Cocoa

public struct LagrangePolynomialCalculator {
    var X: [Double] = []
    var Y: [Double] = []
    var nodeCount: Int = 0
    var x: Double = 0
    var precision: Double = 0
    public init(lowerBound: Double, upperBound: Double, degree: Int, x: Double, precision: Double) {
//        X = equallySpacedInterval(lower: lowerBound, upper: upperBound, degree: degree)
//        Y = getValuesInInterval(interval: X)
//        nodeCount = X.count
//        self.x = x
//        self.precision = precision
    }
//    public mutating func initialize(lBound: Double, uBound: Double, x: Double, precision: Double, degree: Int) {
//        self.degree = degree
//        X = equallySpacedInterval(lower: lBound, upper: uBound, degree: degree)
//        Y = getValuesInInterval(interval: X)
//        self.x = x
//        self.precision = precision
//        result = calculatePolynomial(for: x)
//        print("Calculated value in lagrange polynomial with chavesky spaced nodes is \(result)")
//        print("Calculated maximal error in this polynomial at given interval \(X.first!) and \(X.last!) with precision of \(precision) is \(calculateError())\n\n")
//    }
    public func printAllAbout() {
        let y = calculatePolynomial(for: self.x)
        print("Calculated value in lagrange polynomial with evenly spaced nodes is \(y)")
        print("Calculated maximal error in this polynomial at given interval \(X.first!) and \(X.last!) with precision of \(precision) is \(calculateError(precision: precision))")
        print("")
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
        // Function made for calculation of equally spaced interval,
        var returnArray: [Double] = []
        if degree == 0 {
            print("[ERROR]Number of nodes can't be equal to \(degree) in lagrange Polynomial, returning empty array")
            return []
        }
        let distance = abs(lBound - uBound)/Double(degree)
        //print("Distance: \(distance)")
        for i in 0 ... degree {
            let spacedNode = lBound + (Double(i) * distance)
            //frprint(spacedNode)
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
    
    func function(_ arg: Double) -> Double {
        return pow(arg, 4)
    }
    func calculateError(precision: Double) -> Double{
        var errorValues: [Double] = []
        print("X.first \(X.first!)  X.last \(X.last!)")
        for step in stride(from: X.first!, through: X.last!, by: precision) {
            errorValues.append(abs(function(step) - calculatePolynomial(for: step)))
        }
        guard let maxError = errorValues.max() else {
            print("Maximum error wasn't found")
            return 0
        }
        return maxError
    }
}




//let lagCalc = LagrangePolynomialCalculator(lowerBound: -1, upperBound: 3, degree: 4, x: 1.5, precision: 0.01)
//lagCalc.printAllAbout()
//let y = lagCalc.calculatePolynomial(for: 1.5)
//print(abs(1.5))
//print(y)
