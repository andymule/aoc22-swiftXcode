import SwiftUI
import SwiftGraph
import TextView

extension Mine {
    func run() {
        loadInput("day2")
        for a in 0...10 {
            pr(a)
        }
        pr("asdssss")
        
        copyout(1+234) // only outputs when a line in changed in xcode, but is selectable in preview
    }
    //Day1()
}

struct ContentView: View {
    let mine = Mine()
    init() {
        mine.run()
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
//            SelectableText(text: output, isSelected: self.$isSelected)
//                .onTapGesture {
//                     self.isSelected.toggle()
//                 }
//                 .onReceive(NotificationCenter.default.publisher(for: UIMenuController.willHideMenuNotification)) { _ in
//                     self.isSelected = false
//                 } .onAppear {  // onAppear needs line change in code to work
//                     output = mine.copyablestr
//                 }
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
    }
    
    // text-copyable string
    // only outputs when a line in changed in xcode, but is selectable in preview
    func copyout(_ str: Any) {
        self.copyablestr += "\n" + "\(str)"
    }

    func loadInput(_ inputName: String) {
        if let filepath = Bundle.main.path(forResource: inputName, ofType: "txt") {
            input = try! String(contentsOfFile: filepath)
        } else {
            pr("ERROR \(inputName).txt not found")
        }
    }
    public var str = ""
    public var copyablestr = ""
    public var input = ""
}

// split into tokens, parse into things
// let items = lines[i].components(separatedBy: CharacterSet(charactersIn: " \t")).compactMap { Int($0) }
