import Cocoa
import CoreFoundation

var str = "Hello, playground"

class NumericalIntegration {
    let interval: (a: Double, b: Double)
    
    init(interval: (Double, Double)) {
        self.interval = interval
    }
    func integratedFunction(arg: Double) -> Double {
        let ret = (-1 * pow(arg, 2) + arg + 1)*cos(arg)
        return ret
    }
    func function(arg: Double) -> Double {
        let ret = (cos(arg) * (-2 * arg + 1)) - sin(arg) * (-1 * pow(arg, 2) + arg + 1)
        return ret
    }
    func derivedFunction1(arg: Double) -> Double {
        let ret = pow(arg, 2)*cos(arg) + 4 * sin(arg) - arg * cos(arg) - 2 * sin(arg) - 3 * cos(arg)
        return ret
    }
}

extension NumericalIntegration {
//    func calculateFor(n: Int, m: Int) -> Double? {
//        switch n {
//        case 0:
//            return leftRiemannSum(m: m)
//        default:
//            print("Invalid 'n'")
//            return nil
//        }
//        //return nil
//    }
    func printRealValue() {
        print(integratedFunction(arg: interval.b) - integratedFunction(arg: interval.a))
    }
    func leftRiemannSum(m: Int) -> (result: Double, error: Double) {
        var sum: Double = 0
        let space = (interval.b - interval.a) / Double(m)
        for point in 0..<m {
            sum = sum + function(arg: interval.a + Double(point) * space)
        }
        let result = sum * space
        let error = (integratedFunction(arg: interval.b) - integratedFunction(arg: interval.a)) - result
        return (result, error)
    }
    func trapezoidal(m: Int) -> (result: Double, error: Double) {
        var sum: Double = 0
        let space = (interval.b - interval.a) / Double(m)
        for point in 0...m {
            sum = sum + function(arg: interval.a + Double(point) * space)
        }
        let result = (space / 2.0) * sum
        let error = (integratedFunction(arg: interval.b) - integratedFunction(arg: interval.a)) - result
        return (result, error)
    }
    func simpson(m: Int) -> (result: Double, error: Double) {
        let space = (interval.b - interval.a) / 2.0
        let result = (1.0 / 3.0) * space * (function(arg: interval.a) + 4 * function(arg: interval.a + space) + function(arg: interval.b))
        let error =  (integratedFunction(arg: interval.b) - integratedFunction(arg: interval.a)) - result
        return (result, error)
    }
    func boole() -> (result: Double, error: Double) {
        let space = (interval.b - interval.a) / 4.0
        let result = (space / 90.0) * (7 * function(arg: interval.a) + 32 * function(arg: interval.a + space) + 12 * function(arg: interval.a + 2 * space) + 32 * function(arg: interval.a + 3 * space) + 7 * function(arg: interval.b))
        
        let error = (integratedFunction(arg: interval.b) - integratedFunction(arg: interval.a)) - result
        return (result, error)
    }
    func chebyshew(n: Int, m: Int) -> (result: Double, error: Double) {
        var chebyNodes = [Double]()
        if n == 2 {
            chebyNodes.append(-0.577350)
            chebyNodes.append(0.577350)
        } else if n == 4 {
            chebyNodes.append(-0.794654)
            chebyNodes.append(-0.187592)
            chebyNodes.append(0.187592)
            chebyNodes.append(0.794654)
        }
        var chebyIntegral: Double = 0
        let length = interval.b - interval.a
        for i in 1 ... m {
            var integral = 0.0
            //var X = [Double]()
            let c = interval.a + Double(i - 1) * (length / Double(m))
            let d = interval.a + Double(i) * length / Double(m)
            for i in 0 ..< n {
                let X = (c + d) / 2.0 + (length / Double(m)) * chebyNodes[i] / 2.0
                integral = integral + function(arg: X)
            }
            integral = integral * length / Double(m) / Double(n)
            chebyIntegral = chebyIntegral + integral
        }
        let result = chebyIntegral
        let error = (integratedFunction(arg: interval.b) - integratedFunction(arg: interval.a)) - result
        return (result , error)
    }
}
let _ = NumericalIntegration(interval: (0, 3)).printRealValue()
let riemann = NumericalIntegration(interval: (0, 3)).leftRiemannSum(m: 1)
let trapezoid = NumericalIntegration(interval: (0, 3)).trapezoidal(m: 1)
let simpson = NumericalIntegration(interval: (0, 3)).simpson(m: 1)
let boole = NumericalIntegration(interval: (0, 3)).boole()
let chebyshew21 = NumericalIntegration(interval: (0, 3)).chebyshew(n: 2, m: 1)
let chebyshew41 = NumericalIntegration(interval: (0, 3)).chebyshew(n: 4, m: 1)
let chebyshew22 = NumericalIntegration(interval: (0, 3)).chebyshew(n: 2, m: 2)
print("Trapezoid")
print(trapezoid)
print("Riemann")
print(riemann)
print("Simpson")
print(simpson)
print("Boole")
print(boole)
print("Chebyshew n: 2, m: 1")
print(chebyshew21)
print("Chebyshew n: 4, m: 1")
print(chebyshew41)
print("Chebyshew n: 2, m: 2")
print(chebyshew22)
