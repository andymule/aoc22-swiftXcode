//import SwiftGraph
import SwiftUI
//import TextView
//import simd
//import VectorKit
//import Accelerate
//import BigNumber

/// this command will prInt64 to terminal the output of the preview screen
/// & should run in or your local active folder
/// ~/Library/Developer/Xcode/UserData/Previews/Simulator\ Devices/53F099E6-21B0-4FE4-94CF-7BA756439400/data/Containers/Data/Application
/// watch -n 0.1 find . -name "AOC.txt" -exec cat {} +
/// watch -n 0.1 pkill "Problem Reporter"
/// 􀆔+􀆕+P reloads preview if stopped
class Mine {
    func run() {
        Day11()
    }
    public var str = ""
    public var input = "NO FILE LOADED"
}

struct ContentView: View {
    let mine = Mine()
    init() {
        mine.run()
        mine.writeout(mine.str)// + "\n" + mine.copyablestr) // writes to txt file in preview folder
    }
    var body: some View {
        Text(mine.str)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}

extension Mine {
    // FAST output, always works as expected, NOT selectable in preview
    func pr(_ str: Any) {
        self.str += "\(str)\n"
//        self.str = self.str.trimmingCharacters(in: .newlines)
    }

    func pr(_ str: Any...) {
        var newBit = ""
        for s in str {
            newBit += "\(s) "
        }
        self.str += "\(newBit)\n"
//        self.str = self.str.trimmingCharacters(in: .newlines)
    }

    func loadInput(_ inputName: String) {
        if let filepath = Bundle.main.path(forResource: inputName, ofType: "txt") {
            input = try! String(contentsOfFile: filepath).trimmingCharacters(in: .newlines)
        } else {
            pr("ERROR \(inputName).txt not found")
        }
    }

    // write to file from previews? wow
    public func writeout(_ str: String)
    {
//        prInt64(str)
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("AOC.txt")
        do {
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR")
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
}

/// split Int64o tokens, parse Int64o things
// let items = lines[i].components(separatedBy: CharacterSet(charactersIn: " \t")).compactMap { Int64($0) }

/// generate list of things using iterator and map
// let aScalars = Character("a").asciiValue!
//var letters: [Character] = (0..<26).map {
//    i in Character(UnicodeScalar(aScalars + i))
//}
