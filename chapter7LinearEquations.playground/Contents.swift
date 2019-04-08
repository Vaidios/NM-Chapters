class Row {
    var rowCoeffs: [Double]!
    init(_ coefficients: [Double]) {
        rowCoeffs = coefficients
    }
}

var matrix: [Row] = [Row([4, 2, -2]),
                     Row([2, 10, 5]),
                     Row([-2, 5, 15])]



func printMatrix(with matrix: [[Double]]) {
    let n = matrix.count
    let m = matrix[0].count

    for row in stride(from: 0, to: n, by: 1) {
        //print(matrix[row])
        for column in stride(from: 0, to: m, by: 1) {
            print(matrix[row][column], terminator: "  ")
        }
        print("")
    }
}
/*
 In Simple iteration method, the function have to take form of x = g + Hx
 */

func simpleIterationMethod(with H: [[Double]], and G: [Double]) {
    let i = H.count
    guard let j = H.first?.count else {return}
    let numberOfIterations = 50
    var n = 0
    var Xn: [Double] = [0, 0, 0]
    while n < numberOfIterations {
        let tempXn = Xn
        Xn = [0, 0, 0]
        for row in stride(from: 0, to: i, by: 1) {
            for column in stride(from: 0, to: j, by: 1) {
                Xn[row] += H[row][column] * tempXn[column]
            }
            Xn[row] += G[row]
        }
        n += 1
    }
    print("After \(n) iterations, we get value of X = \(Xn)")
}
let transformedMatrixH: [[Double]] = [[0, -1/2, 1/2],
                                      [-1/5, 0 , -1/2],
                                      [1/8, -5/14, 0]]

let transformedMatrixG: [Double] = [0, 6/5, 26/14]

simpleIterationMethod(with: transformedMatrixH, and: transformedMatrixG)
