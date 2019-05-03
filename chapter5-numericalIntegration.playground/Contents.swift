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
        var sum: Double = 0
        let space = (interval.b - interval.a) / Double(m + 1)
        //cośtam dalej trzeba zapisać
        //sory. kolejny pusty upload
        //3.05 kolejny, weź się w garść cwelu
    }
}

let riemann = NumericalIntegration(interval: (0, 3)).leftRiemannSum(m: 4)
let trapezoid = NumericalIntegration(interval: (0, 3)).trapezoidal(m: 4)
print(riemann)
print(trapezoid)
