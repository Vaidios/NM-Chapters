import Cocoa



class Eigen {

    var x1 = 1.0
    var x2 = 1.0
    var lambda = 0.0
    let matrix: [[Double]]
    
    init(matrix: [[Double]]) {
        self.matrix = matrix
    }
    
    func x1(lambda: Double, x1: Double, x2: Double) -> Double {
        let first = 1.0 / lambda
        let second = (2.0 * x1) - x2
        return first * second
    }
    
    func x2(lambda: Double, x1: Double, x2: Double) -> Double {
        let first = 1.0 / lambda
        let second = (-1.0 * x1) + (2.0 * x2) - 1
        return first * second
    }
    
    func lambda(x2: Double) -> Double {
        return -x2 - 2.0
    }
    
    func iteration(n: Int) {
        lambda = lambda(x2: x2)
        print(x1, x2, 1.0, lambda)
        for _ in 0...n {
            let newX1 = x1(lambda: lambda, x1: x1, x2: x2)
            let newX2 = x2(lambda: lambda, x1: x1, x2: x2)
            x1 = newX1
            x2 = newX2
            
        }
    }
}
