import Cocoa

var str = "Hello, playground"

class NetMethod {
    var grid = [[Double]]()
    let h: Double
    let r: Double
    init(h: Double, r: Double) {
        self.h = h
        self.r = r
    }
    func createArray() {
        for n in stride(from: 0, through: 1, by: r) { //z axis
            var row = [Double]()
            for m in stride(from: 0, through: 1, by: h) { //t axis
                row.append(m)
            }
            //print(row)
            grid.append(row)
        }
    }
    func fillArray() {
        createArray()
        for (idxn, n) in grid.enumerated() {
            for (idxm, m) in n.enumerated() {
                
                if idxm == 0 {
                    grid[idxn][idxm] = sin(Double.pi * Double(idxn) * r)
                    //grid[idxn][idxm] = 1.1
                }
                if idxn == 0 {
                    grid[idxn][idxm] = 0.0
                }
                if idxn == grid.endIndex - 1 {
                    grid[idxn][idxm] = 0.0
                    //print("IM IN THE LOOP")
                }
                //print(grid[idxn][idxm], terminator: " ")
            }
            print("")
        }
    }
    func makeArray() {
        var arr = [[Double]]()
        for _ in stride(from: 0, through: 1, by: h) {
            var row = [Double]()
            for _ in stride(from: 0, through: 1, by: r) {
                row.append(r)
            }
            arr.append(row)
        }
        for (idxn, n) in arr.enumerated() {
            for (idxm, _) in n.enumerated() {
                if idxn == 0 {
                    arr[idxn][idxm] = sin(Double.pi * Double(idxm) * r)
                    //grid[idxn][idxm] = 1.1
                }
                if idxm == 0 {
                    arr[idxn][idxm] = 0.0
                }
                if idxm == arr.endIndex - 1 {
                    arr[idxn][idxm] = 0.0
                    //print("IM IN THE LOOP")
                }
                //print("w(\(idxn), \(idxm)) = \(arr[idxn][idxm])", terminator: " ")
                print("\(arr[idxn][idxm])", terminator: " ")
            }
            print("")
        }
        let a = 0.4
        for (idxn, n) in arr.enumerated() {
            for (idxm, _) in n.enumerated() {
                if idxn != 0 && idxm != 0 && idxm != arr.first!.endIndex - 1 {
//                    print("""
//                        Solving for \(idxn), \(idxm)
//                        value of w(\(idxn - 1), \(idxm - 1)) = \(arr[idxn - 1][idxm - 1])
//                        value of w(\(idxn - 1), \(idxm)) = \(arr[idxn - 1][idxm])
//                        value of w(\(idxn - 1), \(idxm + 1)) = \(arr[idxn - 1][idxm + 1])
//                        """)
                    let first = arr[idxn - 1][idxm] + pow(a, 2) * h * pow(r, -2.0)
                    let second = arr[idxn - 1][idxm + 1] + -2.0 * arr[idxn - 1][idxm] + arr[idxn - 1][idxm - 1]
                    arr[idxn][idxm] = first * second
                    let round = String(format: "%.2f", arr[idxn][idxm]).replacingOccurrences(of: ".", with: ",")
                    print("w(\(idxn), \(idxm)) = \(round)", terminator: " ")
                    
                }
            }
            print("")
        }
    }

    func calculate() {
        fillArray()
        let a = 0.3
        for (idxn, n) in grid.enumerated() {
            for (idxm, m) in n.enumerated() {
                if idxn != 0 && idxn != grid.endIndex - 1  && idxm != 0 {
                    //let first = grid[idxn][idxm - 1] + pow(a, 2) * h * pow(r, -2.0)
                    //let second = grid[idxn][idxm + 1] + -2.0 * grid[idxn][idxm] + grid[idxn][idxm - 1]
//                    let first = grid[idxn][idxm - 1] + pow(a, 2) * h * pow(r, -2.0)
//                    let second = grid[idxn + 1][idxm - 1] + -2.0 * grid[idxn][idxm - 1] + grid[idxn - 1][idxm]
                    //grid[idxn][idxm] = first * second
                    let round = String(format: "%.2f", grid[idxn][idxm]).replacingOccurrences(of: ".", with: ",")
                    print("""
                        Solving for \(idxn), \(idxm)
                        value of w(\(idxn - 1), \(idxm - 1)) = \(grid[idxn - 1][idxm - 1])
                        value of w(\(idxn), \(idxm - 1)) = \(grid[idxn][idxm - 1])
                        value of w(\(idxn + 1), \(idxm - 1)) = \(grid[idxn + 1][idxm - 1])
                        """)
                    
//                    if grid[idxn][idxm] > 0.00001 {
//                        print(round, terminator: " ")
//                    }
                    //break
                }
                //w(z, t)
                //print("\(idxn), \(idxm)", terminator: " | ")
                //print(grid[0][idxm], terminator: " ")
                //print(grid[idxn][idxm], terminator: " ")
            }
            //break
            print("")
            
        }
    }
}


//NetMethod(h: 0.1, r: 0.1).calculate()
NetMethod(h: 0.1, r: 0.1).makeArray()
