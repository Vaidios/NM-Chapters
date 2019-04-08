import Foundation

public extension NumericalDiffrentiation {
    func backwardDiffrence(degree: Int) -> Double? {

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
            let newX = x0 - Double(x) * h
            let funcX = function(x: newX)
            X.append(newX)
            Y.append(funcX)
        }
        for k in 0 ..< n {
            let D = n - k
            var tempY: [Double] = []
            for Δ in 0 ..< D {
                let temp = Y[Δ] - Y[Δ + 1]
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
            return nil
        }
    }
    fileprivate func derivative1(Y: [Double]) -> Double {
        let h1 = 1 / h
        let rest = Y[0] + 1.0/2.0 * Y[1] + 1.0/3.0 * Y[2] + 1.0/4.0 * Y[3]
        return h1 * rest
    }
    fileprivate func derivative2(Y: [Double]) -> Double {
        let h1 = 1 / pow(h, 2)
        let rest = Y[1] + Y[2] + 11.0/12.0 * Y[3]
        return h1 * rest
    }
    fileprivate func derivative3(Y: [Double]) -> Double {
        let h1 = 1 / pow(h, 3)
        let rest = Y[2] + 3.0/2.0 * Y[3]
        return h1 * rest
    }
}
