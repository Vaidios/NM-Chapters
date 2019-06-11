import Cocoa

var str = ""

class NonLinearSolver {
    let interval: (Double, Double)
    init(interval: (Double, Double)) {
        self.interval = interval
    }
    func function(_ arg: Double) -> Double {
        return pow(arg, 4) - 625
    }
    func printFirst(accuracy: Double) {
        print("REGULA FALSI")
        regulaFalsi(accuracy)
        print("\nNEWTON")
        newton(accuracy: accuracy)
    }
    func regulaFalsi(_ accuracy: Double) {
        let diffCalc = NumericalDiffrentiation(x0: interval.0, h: 0.001, n: 4)
        var i = 1
        //guard let diffrentiated = diffCalc.backwardDiffrence(degree: 2) else { return }
        if function(interval.1) * NumericalDiffrentiation(x0: interval.1, h: 0.001, n: 4).backwardDiffrence(degree: 2)! > 0 {
            var x1 = interval.0
            print("b chosen")
            while abs(function(x1)) > accuracy {
                x1 = x1 - (function(x1) * (interval.1 - x1)) / (function(interval.1) - function(x1))
                print("k=\(i): \(x1)   f(x)= \(function(x1))")
                i = i + 1
            }
            
        } else if function(interval.0) * NumericalDiffrentiation(x0: interval.0, h: 0.001, n: 4).backwardDiffrence(degree: 2)! > 0  {
            print("a chosen")
            var x1 = interval.1
            //print("k=\(i): \(x1)   f(x)= \(function(x1))")
            while abs(function(x1)) > accuracy {
                x1 = x1 - (function(x1) * (interval.0 - x1)) / (function(interval.0) - function(x1))
                print("k=\(i): \(x1)   f(x)= \(function(x1))")
                i = i + 1
            }
        }
        //print(function(interval.0), NumericalDiffrentiation(x0: interval.0, h: 0.001, n: 4).backwardDiffrence(degree: 2)!)
    }
    func polynomial(arg: Double) -> Double {
        //[1, 7, -94, -328, 960]
        return pow(arg, 4.0) + 7.0 * pow(arg, 3.0) + -94.0 * pow(arg, 2.0) + -328.0 * pow(arg, 1.0) + 960.0
    }
    
    func newton(accuracy: Double) {
        var i = 1
        var x1 = 0.0
        if function(interval.0) * NumericalDiffrentiation(x0: interval.0, h: 0.001, n: 4).backwardDiffrence(degree: 2)! > 0 {
            x1 = interval.0
            while abs(function(x1)) > accuracy {
                guard let diffrentiated1 = NumericalDiffrentiation(x0: x1, h: 0.001, n: 4).backwardDiffrence(degree: 1) else { return }
                x1 = x1 - function(x1) / diffrentiated1
                print("k=\(i): \(x1)   f(x)= \(function(x1))")
                i = i + 1
            }
        } else if function(interval.1) * NumericalDiffrentiation(x0: interval.1, h: 0.001, n: 4).backwardDiffrence(degree: 2)! > 0 {
            x1 = interval.1
            while abs(function(x1)) > accuracy {
                guard let diffrentiated1 = NumericalDiffrentiation(x0: x1, h: 0.001, n: 4).backwardDiffrence(degree: 1) else { return }
                x1 = x1 - function(x1) / diffrentiated1
                print("k=\(i): \(x1)   f(x)= \(function(x1))")
                i = i + 1
            }
        }
    }
    
    func bernoulli(n: Int, a: [Double], accuracy: Double) {
        if n + 1 != a.count {
            return
        }
        var k = 1
        var xk = 0.0
        var yValues = [Double]()
        for _ in 0 ..< n {
            yValues.append(2.0)
        }
        while abs(polynomial(arg: xk)) > accuracy {
            var sum = 0.0
            for (i, y) in yValues.enumerated() {
                if i != yValues.count - 1 {
                    sum = sum + y * a[i]
                }
            }
            let yk = (-1.0 / a.last!) * sum
            xk = yk / yValues.last!
            yValues.removeFirst()
            yValues.append(yk)
            print("xk: \(xk), f(x): \(polynomial(arg: xk)), yValues: \(yValues)")
        }
    }
}

let _ = NonLinearSolver(interval: (-10.0, -1.0)).printFirst(accuracy: 0.001)
print("BERNOULLI")
let _ = NonLinearSolver(interval: (-10.0, -1.0)).bernoulli(n: 4, a: [1, 7, -94, -328, 960], accuracy: 0.001)
