import Cocoa
import Darwin

// MARK: - Writing to files
func writeToFile(filename: String = "appDiff.txt", contents: (Double, Double)) {
    let roundX = String(format: "%.2f", contents.0).replacingOccurrences(of: ".", with: ",")
    let roundY = String(format: "%.2f", contents.1).replacingOccurrences(of: ".", with: ",")
    let content = "\(roundX) \(roundY)\r"
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
func removeFile(filename: String = "appDiff.txt") {
    let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    let fileURL =  dir.appendingPathComponent(filename)
    do {
        try FileManager.default.removeItem(at: fileURL)
    } catch { print(error) }
}
//-----------------------------------------------
//FUNCTIONS
func function1(x: Double, y: Double) -> Double {
    return -2.0 * y + 5.0 * exp(-2.0 * x)
}
func function2(x: Double, y: Double) -> Double {
    return 5.0 * y + 10.0 * exp(0)
}
func function3(x: Double, y: Double) -> Double {
    return 2.0 * x * y
}
//

class RungeKutta{
    let x0, y0, h, xn: Double
    var x, y: Double
    init(x0: Double, y0: Double, xn: Double, step: Double) {
        self.x0 = x0
        self.y0 = y0
        self.xn = xn
        self.h = step
        x = x0
        y = y0
    }
    func RungeKuta4(step: Double, x: Double, y: Double, f: (Double, Double) -> Double) -> Double {
        let k1 = step * f(x, y)
        let k2 = step * f(x + step * 0.5, y + k1 * 0.5)
        let k3 = step * f(x + step * 0.5, y + k2 * 0.5)
        let k4 = step * f(x + step, y + k3)
        let k = (k1 + 2.0 * k2 + 2.0 * k3 + k4) * 1.0/6.0
        //print(k1, k2, k3, k4)
        print("Final k: \(String(format: "X: %.5f", k))")
        print("")
        return k
    }
    func calculate(f: (Double, Double) -> Double) {
        removeFile()
        print("------------------START---------------------")
        while x <= xn {
            print("X: \(String(format: "X: %.5f", x)), Y: \(String(format: "X: %.5f", y))")
            writeToFile(contents: (x, y))
            let k = RungeKuta4(step: h, x: x, y: y, f: f)
            y = y + k
            x = x + h
        }
        print("------------------DONE---------------------\n\n\n")
    }

}
RungeKutta(x0: 0, y0: -10.0, xn: 5, step: 0.5).calculate(f: function1)

