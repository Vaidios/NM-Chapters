import Cocoa
import CoreFoundation

var str = "Hello, playground"

class NumericalIntegration {
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
