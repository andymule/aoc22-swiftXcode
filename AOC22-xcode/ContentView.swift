import SwiftGraph
import SwiftUI
import TextView
import simd
//import VectorKit
//import Accelerate
//import BigNumber

/// this command will prInt64 to terminal the output of the preview screen
/// & should run in or your local active folder
/// ~/Library/Developer/Xcode/UserData/Previews/Simulator Devices/D838DED4-7024-4819-9044-10E54C7733AE/data/Containers/Data
/// watch -n 0.1 find . -name "AOC.txt" -exec cat {} +
/// watch -n 0.1 pkill "Problem Reporter"
/// 􀆔+􀆕+P reloads preview if stopped
class Mine {
    func run() {
        class Point: Codable, Equatable, Hashable {
            static func == (lhs: Point, rhs: Point) -> Bool {
                return lhs.pointS == rhs.pointS
            }
            let point: [Int]
            let pointS: String
            var h: Int
            var graphI: Int = -1
            var startPoint = false
            var endPoint = false
            init(_ h: Character, _ p: [Int]) {
                self.h = Int(h.asciiValue!) - 97
                point = p
                pointS = String(p[0]) + "," + String(p[1])
            }
            func near(_ nextp: Point) -> Bool {
                let nextpx = nextp.h
                return nextpx == h || nextpx == h + 1 //|| nextpx == h - 1 //||
            }
            func hash(into hasher: inout Hasher) {
                hasher.combine(point[0] * 100)
                hasher.combine(point[1])
            }
        }

        var graph: UnweightedGraph<String> = .init()
//        var graph: Graph<[Point], Int> = .init()
//        graph.vertices.insert(contentsOf: <#T##C#>, at: <#T##Self.Index#>)
        loadInput("day12")
//        pr(input)
        var map: [[Int]: Point] = .init()
        let lines = input.components(separatedBy: "\n")
        for y in 0..<lines.count {
            let line = lines[y]
            for x in 0..<line.count {
                let newP = Point(line[x], [y, x])
                if line[x] == "S" {
                    newP.h = 0
                    newP.startPoint = true
                }
                if line[x] == "E" {
                    newP.h = 25
                    newP.endPoint = true
                }
                map[[y, x]] = newP
                newP.graphI = graph.addVertex(newP.pointS)
//                pr(newP.pointS,newP.point,newP.graphI,newP.h,newP.startPoint || newP.endPoint)
//                pr(newP.pointS)
//                pr(xxx)
            }
        }
//        var startI = -1
//        var endI = -1
        for y in 0..<lines.count {
            let line = lines[y]
            for x in 0..<line.count {
                let thisP = map[[y, x]]!
                if y > 1 {
                    let thatP = map[[y - 1, x]]!
                    if thisP.near(thatP) {

                        graph.addEdge(from: thisP.pointS, to: thatP.pointS)//, weight: thatP.h - thisP.h)
//                        graph.add
                    }
                }
                if y < lines.count - 1 {
                    let thatP = map[[y + 1, x]]!
                    if thisP.near(thatP) {
                        graph.addEdge(from: thisP.pointS, to: thatP.pointS)//, weight: thatP.h - thisP.h)
                    }
                }
                if x > 1 {
                    let thatP = map[[y, x - 1]]!
                    if thisP.near(thatP) {
                        graph.addEdge(from: thisP.pointS, to: thatP.pointS)//, weight: thatP.h - thisP.h)
                    }
                }
                if x < line.count - 1 {
                    let thatP = map[[y, x + 1]]!
                    if thisP.near(thatP) {
                        graph.addEdge(from: thisP.pointS, to: thatP.pointS)//, weight: thatP.h - thisP.h)
                    }
                }
            }
        }
//        pr(graph.edgeCount)
//        pr(graph.vertices)

//        pr(map.map({$0.value.h}))
//        pr(map[[0,0]]?.h)
        let startP: Point = map.values.filter({ $0.startPoint })[0]
        let endP: Point = map.values.filter({ $0.endPoint })[0]
//        for g in graph.ed {
//            pr(g)
//        }

//        let (distances, pathDict) = graph.dijkstra(root: startP.pointS, startDistance: 1)
        var a = graph.indexOfVertex(startP.pointS)!
        var b = graph.indexOfVertex(endP.pointS)!
        pr(a, b)
        let g = graph.distance(from: a, to: b)
        let g2 = graph.dfs(fromIndex: a, toIndex: b)
        pr(g, g2)
//        var nameDistance: [String: Int?] = distanceArrayToVertexDict(distances: distances, graph: graph)
//        pr(nameDistance)
//        // shortest distance from New York to San Francisco
//        let temp = nameDistance[endP.pointS] //map[[0,2]]!.pointS]!
//        pr(temp)
//        // path between New York and San Francisco
//        let path: [WeightedEdge<Int>] = pathDictToPath(from: graph.indexOfVertex(startP.pointS)!, to: graph.indexOfVertex(startP.pointS)!, pathDict: pathDict)
//        let stops: [String] = graph.edgesToVertices(edges: path)
//        pr(stops)

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
