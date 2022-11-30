import SwiftUI
import SwiftGraph

extension Mine {
    func run() {
        loadInput("day1")
        pr("testing")
    }
}

struct ContentView: View {
    let mine = Mine()
    init () {
        mine.run()
        let _ = print("hi?")
    }
    var body: some View {
        VStack {
            Text(mine.str).bold().Print(mine.str)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}

class Mine {
    func pr(_ str: Any) {
        self.str += "\n" + "\(str)"
    }

    func loadInput(_ inputName: String) {
        if let filepath = Bundle.main.path(forResource: inputName, ofType: "txt") {
            do {
                input = try! String(contentsOfFile: filepath)
            } catch {
                pr("CONTENT LOAD ERROR")
            }
        } else {
            pr("ERROR \(inputName).txt not found")
        }
    }
    public var str = ""
    public var input = ""
}

extension View {
    func Print(_ item: Any) -> some View {
        #if DEBUG
            print(item)
        #endif
        return self
    }
}
