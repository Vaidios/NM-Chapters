import Foundation



enum Parameter {
    case h
    case n
}

extension NumericalDiffrentiation {
    func adjustParameters(x1: Double, accuracy: Double, h1: Double, n1: Int, adjustable: Parameter) -> (Double, Int) {
        var h1 = h1
        let degree = 1
        let step = 0.00001
        let stepCount = 1000
        let directionTest1 = forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1)!
        let directionTest2 = forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1 + step)!
        let error1 = overallError(value: directionTest1)
        //let error2 = overallError(value: directionTest2)
        var achievedAcc: Double = abs(error1)
        var currentStep = 0
        print("[ADJUST]Achieved accuracy \(achievedAcc), accuracy: \(accuracy)")
        while achievedAcc > accuracy {
            h1 = h1/10
            let newError = overallError(value: forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1)!)
            achievedAcc = abs(newError)
            if currentStep > stepCount {
                break
            }
            currentStep = currentStep + 1
        }
        
//        if error1 > error2 {
//            repeat {
//                h1 = h1 + step
//                let newError = overallError(value: forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1)!)
//                achievedAcc = abs(newError)
//                if currentStep > stepCount {
//                    break
//                }
//                currentStep = currentStep + 1
//            } while accuracy < achievedAcc
//
//        } else {
//            repeat {
//                h1 = h1 - step
//                let newError = overallError(value: forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1)!)
//                achievedAcc = abs(newError)
//                if currentStep > stepCount {
//                    break
//                }
//                currentStep = currentStep + 1
//
//            } while accuracy < achievedAcc
//            print("Achieved accuracy: \(achievedAcc)")
//        }
        //var achievedAcc2 = forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1 - step)
        print("Achieve accuracy after iterations \(achievedAcc)")
        //print("Function derivative: \(forwardDiffrence(degree: degree, x1: x1, n1: n1, h1: h1))")
        return (h1, n1)
    }
    
}



public extension NumericalDiffrentiation {
    func diffrentiate(function: () -> Double, degree: Int) {
        
    }
    func forwardDiffrence(degree: Int, x1: Double, n1: Int, h1: Double ) -> Double? {
        let x0 = x1
        let n = n1
        let h = h1
        if degree == 0 {
            return function(x: x0)
        }
        if n < degree {
            print("[FORWARD] n cannot be lower than degree")
            return nil
        }
        if degree > 3 {
            print("Sorry, I don't have formulas for that 😭")
            return nil
        }
        var X: [Double] = []
        var Y: [Double] = []
        var finalY: [Double] = []
        for x in 0..<n + 1 {
            let newX = x0 + Double(x) * h
            let funcX = function(x: newX)
            X.append(newX)
            Y.append(funcX)
        }
        for k in 0 ..< n {
            let D = n - k
            var tempY: [Double] = []
            for Δ in 0 ..< D {
                let temp = Y[Δ + 1] - Y[Δ]
                tempY.append(temp)
            }
            Y = tempY
            guard let Diff = Y.first else {
                print("[FORWARD] No value")
                return nil
            }
            finalY.append(Diff)
        }
        switch degree {
        case 1:
            return derivative1(Y: finalY)
        case 2:
            return derivative2(Y: finalY)
        case 3:
            return derivative3(Y: finalY)
        default:
            print("[FORWARD] something is wrong with degree value")
            return nil
        }
    }
    fileprivate func derivative1(Y: [Double]) -> Double {
        let h1 = 1 / h
        let rest = Y[0] - 1.0/2.0 * Y[1] + 1.0/3.0 * Y[2] - 1.0/4.0 * Y[3]
        return h1 * rest
    }
    fileprivate func derivative2(Y: [Double]) -> Double {
        let h1 = 1 / pow(h, 2)
        let rest = Y[1] - Y[2] + 11.0/12.0 * Y[3]
        return h1 * rest
    }
    fileprivate func derivative3(Y: [Double]) -> Double {
        let h1 = 1 / pow(h, 3)
        let rest = Y[2] - 3.0/2.0 * Y[3]
        return h1 * rest
    }
    
}


let diff = NumericalDiffrentiation(x0: 1, h: 10, n: 2)
//let adjustParameters = diff.adjustParameters(x1: 1, accuracy: 0.01, h1: 0.1, n1: 4, adjustable: .h)
//let resultFor = diff.forwardDiffrence(degree: 1)
let resultBack = diff.backwardDiffrence(degree: 1)
//print("Adjusted h0: \(adjustParameters.0), n: \(adjustParameters.1)")
let errorFor = diff.overallError(value: resultBack!)
print("[FORWARD] is equal to \(resultBack!) and error is \(errorFor)")
