import Cocoa

func writeToFile(filename: String = "appPart.txt", contents: (Double, Double, String)) {
    let roundX = String(format: "%.2f", contents.0).replacingOccurrences(of: ".", with: ",")
    let roundY = String(format: "%.2f", contents.1).replacingOccurrences(of: ".", with: ",")
    let content = "\(roundX) \(roundY) \(contents.2)\r"
    //print("REAL: \(content)")
    let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    let fileURL =  dir.appendingPathComponent(filename)
    do {
        let filehandle = try FileHandle(forWritingTo: fileURL)
        filehandle.seekToEndOfFile()
        filehandle.write(content.data(using: .utf8)!)
        filehandle.closeFile()
        
    } catch {
        do {
            try content.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch { print(error)}
    }
}
func removeFile(filename: String = "appPart.txt") {
    let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    let fileURL =  dir.appendingPathComponent(filename)
    do {
        try FileManager.default.removeItem(at: fileURL)
    } catch { print(error) }
}

class NetMethod {
    var grid = [[Double]]()
    let h: Double
    let r: Double
    let a: Double
    init(h: Double, r: Double, a: Double) {
        self.h = h
        self.r = r
        self.a = a
    }
    func analytical(t: Double, z: Double) -> Double {
        return exp(pow(-Double.pi, 2) * pow(a, 2) * t) * sin(Double.pi * z)
    }
    func createArray() {
        let conv = pow(a, 2) * h / pow(r, 2)
        //print("Convergence: \(conv)")
        if conv > 0.5 {
            print("ALERT: CONVERGENCE FORMULA NOT SATISFIED")
        } else {
            print("Convergence requirement is met\n\n")
        }
        var grid = [[Double]]()
        for _ in stride(from: 0, through: 1, by: h) {
            var row = [Double]()
            for _ in stride(from: 0, through: 1, by: r) {
                row.append(r)
            }
            grid.append(row)
        }
        self.grid = grid
    }
    func fillArray() {
        createArray()
        for (idxn, n) in grid.enumerated() {
            for (idxm, _) in n.enumerated() {
                if idxn == 0 {
                    grid[idxn][idxm] = sin(Double.pi * Double(idxm) * r)
                    //grid[idxn][idxm] = 1.1
                }
                if idxm == 0 {
                    grid[idxn][idxm] = 0.0
                }
                if idxm == grid.first!.endIndex - 1 {
                    grid[idxn][idxm] = 0.0
                    //print("IM IN THE LOOP")
                }
                //print(grid.endIndex - 1)
                //print("w(\(idxn), \(idxm)) = \(grid[idxn][idxm])", terminator: " ")
                print("\(idxn) \(idxm)", terminator: " | ")
                //print("\(grid[idxn][idxm])", terminator: " ")
            }
            print("")
        }
    }
    func calculate() {
        removeFile()
        fillArray()
        print("Finished table")
        var MSE: Double = 0
        var iteration: Int = 0
        for (idxn, n) in grid.enumerated() {
            for (idxm, _) in n.enumerated() {
                if idxn != 0 && idxm != 0 && idxm != grid.first!.endIndex - 1 {
                    let first = grid[idxn - 1][idxm]
                    let second = pow(a, 2) * h * pow(r, -2.0)
                    let third = grid[idxn - 1][idxm + 1] + -2.0 * grid[idxn - 1][idxm] + grid[idxn - 1][idxm - 1]
                    grid[idxn][idxm] = first + second * third
                    //print(grid[idxn][idxm], terminator: "   |   ")
                    //print("For \(idxn) \(idxm) = \(grid[idxn][idxm])")
                }
                //print(grid[idxn][idxm], terminator: "   |   ")
                let realValue = analytical(t: Double(idxn) * h, z: Double(idxm) * r)
                MSE = MSE + pow(realValue, 2)
                iteration = iteration + 1
                let roundCalc = String(format: "%.3f", grid[idxn][idxm]).replacingOccurrences(of: ".", with: ",")
                let roundReal = String(format: "%.3f", realValue).replacingOccurrences(of: ".", with: ",")
                print("Calc: \(roundCalc), Real: \(roundReal)", terminator: " | ")
                writeToFile(contents: (Double(idxn) * r, Double(idxm) * h, roundReal))
                
            }
            print("")
        }
        print("Mean squared error is: \(MSE / Double(iteration))")
    }
}
NetMethod(h: 0.1, r: 0.2, a: 0.3).calculate()
