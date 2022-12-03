import SwiftGraph
import SwiftUI
import TextView

// this command will print to terminal the output of the preview screen
///should run in ~/Library/Developer/Xcode/UserData/Previews/Simulator Devices/53F099E6-21B0-4FE4-94CF-7BA756439400/data/Containers/Data/Application
// watch -n 0.1 find . -name "AOC.txt" -exec cat {} +
extension Mine {
    func run() {
        loadInput("day4")
        pr("READY")
    }
    // special weird command that write to copyable text IN SIMULATOR (not copyable in preview)
    // in case the string you need as output is really long/weird/hard to visually copy
    // copyout("special output")
}

struct ContentView: View {
    let mine = Mine()
    init() {
        mine.run()
        mine.writeout(mine.str + "\n" + mine.copyablestr) // writes to txt file in preview folder
    }

    @State private var output: String = ""
    @State private var isSelected = false
    var body: some View {
        VStack {
            Text(mine.str).textSelection(.enabled)
            TextView($output).font(.title2).fontWeight(.bold)
                .onAppear { // onAppear needs line change in code to work
                output = mine.copyablestr
            }
        }.textSelection(.enabled)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}

class Mine {
    // FAST output, always works as expected, NOT selectable in preview
    func pr(_ str: Any) {
        self.str += "\n" + "\(str)"
        self.str = self.str.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // text-copyable string
    // only outputs when a line in changed in xcode, but is selectable in preview
    func copyout(_ str: Any) {
        copyablestr += "\n" + "\(str)"
        copyablestr = copyablestr.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func loadInput(_ inputName: String) {
        if let filepath = Bundle.main.path(forResource: inputName, ofType: "txt") {
            input = try! String(contentsOfFile: filepath).trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            pr("ERROR \(inputName).txt not found")
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // write to file from previews? wow
    public func writeout(_ str: String)
    {
//        let str = "Super long string here"
        print(str)
        let filename = getDocumentsDirectory().appendingPathComponent("AOC.txt")
        do {
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR")
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }

    public var str = ""
    public var copyablestr = ""
    public var input = ""
}

// split into tokens, parse into things
// let items = lines[i].components(separatedBy: CharacterSet(charactersIn: " \t")).compactMap { Int($0) }
