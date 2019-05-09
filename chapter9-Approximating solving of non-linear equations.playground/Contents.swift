import Cocoa

var str = ""

class NonLinearSolver {
    let interval: (Double, Double)
    init(interval: (Double, Double)) {
        self.interval = interval
    }
    func function(_ arg: Double) -> Double {
        return exp(arg - 1.0) + pow(arg, 2) - 2
    }
    func bisection() -> Double {
        return 0.0
    }
    func regulaFalsi(_ accuracy: Double) {
        let diffCalc = NumericalDiffrentiation(x0: interval.0, h: 0.001, n: 4)
        var i = 1
        guard let diffrentiated = diffCalc.backwardDiffrence(degree: 2) else { return }
        if function(interval.0) * diffrentiated < 0 {
            var x1 = interval.0
            while abs(function(x1)) > accuracy {
                x1 = x1 - (function(x1) * (interval.1 - x1)) / (function(interval.1) - function(x1))
                print("k=\(i): \(x1)   f(x)= \(function(x1))")
                i = i + 1
            }
            
        } else {
            var x1 = interval.1
            while function(x1) > accuracy {
                x1 = x1 - (function(x1) * (interval.0 - x1)) / (function(interval.0) - function(x1))
                print("k=\(i): \(x1)   f(x)= \(function(x1))")
                i = i + 1
            }
        }
    }
}

let solver = NonLinearSolver(interval: (0.0, 2.0)).regulaFalsi(0.001)
