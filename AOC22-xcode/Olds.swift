import SwiftUI
import Foundation

extension Mine {
    func Day11() {
        func GCD(_ x: Int64, _ y: Int64) -> Int64 {
            var a: Int64 = 0
            var b: Int64 = max(x, y)
            var r: Int64 = min(x, y)

            while r != 0 {
                a = b
                b = r
                r = a % b
            }
            return b
        }

        func LCM(_ x: Int64, _ y: Int64) -> Int64 {
            return x / GCD(x, y) * y
        }

        class monkey {
            let num: Int
            var items: [Int64]
            let operation: String //(Int64, Int64) -> Int64
            let testDivisible: Int64 //(Int64) -> Bool
            var testMap: [Bool: Int] = [:]
            var inspected = 0
            init(num: Int, start: [Int64], operation: String, testDivisible: Int64, testTrue: Int, testFalse: Int) {
                self.num = num
                self.items = start
                self.operation = operation
                self.testDivisible = testDivisible
                testMap[true] = testTrue
                testMap[false] = testFalse
            }
        }

        //        var asd: vS1024


        loadInput("day11")
        let orders = input.components(separatedBy: "\n\n")
        var monkeys: [Int: monkey] = [:]
        var lcm: Int64 = 1
        for order in orders {
            let lines = order.components(separatedBy: "\n")
            let mInt64 = Int(String(lines[0].components(separatedBy: " ")[1].dropLast()))!
            let items = lines[1].components(separatedBy: ":")[1].components(separatedBy: ",").map { Int64($0.trimmingCharacters(in: .whitespaces))! }
            var opers = lines[2].trimmingCharacters(in: .whitespaces).components(separatedBy: "=")[1].trimmingCharacters(in: .whitespaces)
            //            pr(opers)
            let ifDivBy = Int64(lines[3].components(separatedBy: " ").last!)!
            lcm = LCM(lcm, ifDivBy)
            //            pr(lcm)
            let truThro = Int(lines[4].components(separatedBy: " ").last!)!
            let falsThro = Int(lines[5].components(separatedBy: " ").last!)!
            monkeys[mInt64] = monkey(num: mInt64, start: items, operation: opers, testDivisible: ifDivBy, testTrue: truThro, testFalse: falsThro)
        }

        //        let a: BigIn
        //        var round = 1
        //        pr(-24%23)
        let rounds = 10000
        for _ in 1...rounds {
            for i in 0..<monkeys.count {
                let monkey = monkeys[i]!
                while !monkey.items.isEmpty {
                    monkey.inspected += 1
                    let old = monkey.items.popLast()!
                    let oper = monkey.operation.components(separatedBy: " ")[1]
                    let operInt64 = Int64(monkey.operation.components(separatedBy: " ")[2]) ?? old
                    let args = String(old) + oper + String(operInt64)
                    let expression = NSExpression(format: args)
                    let value = Int64(exactly: expression.expressionValue(with: nil, context: nil) as! Int64)!
                    //                    let newVal = value / 3
                    var newVal = value % lcm /// 3
                    //                    pr(round, monkey.num, newVal)
                    let isDiv = (newVal % monkey.testDivisible) == 0
                    //                    if isDiv {
                    //                        newVal = value % monkey.testDivisible
                    //                    }
                    monkeys[monkey.testMap[isDiv]!]!.items.append(newVal)
                }
            }
        }
        for i in 0..<monkeys.count {
            pr(i, monkeys[i]!.items)
        }
        for i in 0..<monkeys.count {
            pr(i, monkeys[i]!.inspected)
        }
        var vals = monkeys.map({ $0.value.inspected }).sorted()
        let monkeyB = vals.popLast()! * vals.popLast()!
        pr(rounds, monkeyB)
        print(rounds, monkeyB)
    }

    func Day10() {
        loadInput("day10")
        var cycle = 1
        var reg = 1
        var totalSum = 0
        let lines = input.components(separatedBy: .newlines)
        var index = 0
        var image = ""
        //        var image = Array(repeating: ".", count: 240)
        //String(repeating: ".", count: 240)
        func inc(_ i: Int) {
            if [reg - 1, reg, reg + 1].contains((cycle-1) % 40) {
                image += "#"
            } else {
                image += "."
            }
            reg += i
            cycle += 1
            //            pr(image)
            //            if (cycle + 20) % 40 == 0 {
            //                let newS = (cycle * reg)
            //                totalSum += newS
            //                pr(cycle, reg, newS)
            //            }
            //            pr(cycle, reg)
            //            if (cycle >= 179)
            //            {
            //                pr(index, cycle, lines[index], i, reg)
            //            }
            //            pr(index, cycle, lines[index], i, reg)
        }

        var jk = 0
        while cycle <= 240 {
            //        while index < lines.count {
            let toks = lines[index].components(separatedBy: " ")
            if toks[0] == "noop" {
                inc(0)
                index += 1 //(index + 1) % lines.count
                continue
            }
            else {
                inc(0)
                inc(Int(toks[1])!)
                index += 1 //(index + 1) % lines.count
            }
            //            if (index > lines.count - 5) {
            //                pr(index)
            //            }
        }
        //        pr(image[0...40])
        //        let bigString = image.map({$0}).joined(seperator : ",")
        //        let bigString = image.map{"\($0)"}.reduce("") { $0 + $1 }
        pr(image[0..<40])
        pr(image[40..<80])
        pr(image[80..<120])
        pr(image[120..<160])
        pr(image[160..<200])
        pr(image[200..<240])
        //        pr(im)
    }

    func Day9() {
        let ropeSize = 10
        var rope: [[Int]] = Array(repeating: [0, 0], count: ropeSize)
        var tailSet: Set<[Int]> = Set()
        loadInput("day9")

        func moveTail(headIndex: Int, tailIndex: Int) {
            let totalDiff = abs(rope[tailIndex][0] - rope[headIndex][0]) + abs(rope[tailIndex][1] - rope[headIndex][1])
            if totalDiff >= 3 {
                let goX = (rope[tailIndex][0] - rope[headIndex][0]).signum()
                rope[tailIndex][0] -= goX
                let goY = (rope[tailIndex][1] - rope[headIndex][1]).signum()
                rope[tailIndex][1] -= goY
                return
            }

            if abs(rope[tailIndex][0] - rope[headIndex][0]) > 1 {
                let go = (rope[tailIndex][0] - rope[headIndex][0]).signum()
                rope[tailIndex][0] -= go
            }
            if abs(rope[tailIndex][1] - rope[headIndex][1]) > 1 {
                let go = (rope[tailIndex][1] - rope[headIndex][1]).signum()
                rope[tailIndex][1] -= go
            }
        }

        tailSet.insert(rope.last!)
        let lines = input.components(separatedBy: .newlines)
        for l in lines {
            let dir = l.components(separatedBy: .whitespacesAndNewlines)[0]
            var amount = Int(l.components(separatedBy: .whitespacesAndNewlines)[1])!
            while amount > 0 {
                amount -= 1
                switch dir {
                case "R":
                    rope[0][0] += 1
                case "L":
                    rope[0][0] -= 1
                case "U":
                    rope[0][1] += 1
                case "D":
                    rope[0][1] -= 1
                default:
                    pr("ERROR AMOUNT")
                }
                for i in 1..<rope.count {
                    moveTail(headIndex: i - 1, tailIndex: i)
                }
                tailSet.insert(rope.last!)
            }
        }
        pr(2, ":", tailSet.count)
    }

    func Day8() {
        class Tree {
            var visible: Bool = false
            let height: Int
            init(_ h: Int) {
                height = h
            }
        }
        loadInput("day8")
        var trees: [([Int]): Tree] = [:]
        let lines = input.components(separatedBy: .newlines)
        for y in 0..<lines.count {
            for x in 0..<lines[y].count {
                let h = Int(String(lines[y][x]))!
                trees[[y, x]] = Tree(h)
            }
        }

        for x in 0..<lines[0].count {
            var tallest = -1
            for y in 0..<lines.count {
                if trees[[y, x]]!.height > tallest {
                    tallest = trees[[y, x]]!.height
                    trees[[y, x]]!.visible = true
                }
            }
        }
        for x in 0..<lines[0].count {
            var tallest = -1
            for y in stride(from: lines.count - 1, to: 0, by: -1) {
                if trees[[y, x]]!.height > tallest {
                    tallest = trees[[y, x]]!.height
                    trees[[y, x]]!.visible = true
                }
            }
        }
        for y in 0..<lines.count {
            var tallest = -1
            for x in 0..<lines[y].count {
                if trees[[y, x]]!.height > tallest {
                    tallest = trees[[y, x]]!.height
                    trees[[y, x]]!.visible = true
                }
            }
        }
        for y in 0..<lines.count {
            var tallest = -1
            for x in stride(from: lines[y].count - 1, to: 0, by: -1) {
                if trees[[y, x]]!.height > tallest {
                    tallest = trees[[y, x]]!.height
                    trees[[y, x]]!.visible = true
                }
            }
        }
        pr(trees.values.filter({ $0.visible }).count)
        pr()

        for f in trees.values {
            f.visible = false
        }

        var MOSTSEEN = 0
        for y in 0..<lines.count {
            for x in 0..<lines[y].count {
                let thisH = trees[[y, x]]!.height
                if y == 3 && x == 2 {
                    _ = 69
                }
                let visUp = {
                    var count = 0
                    var yy = y - 1
                    while yy >= 0 {
                        if trees[[yy, x]]!.height >= thisH {
                            return Int(count + 1)
                        }
                        yy -= 1
                        count += 1
                    }
                    return Int(count)
                }
                let visDown = {
                    var count = 0
                    var yy = y + 1
                    while yy < lines.count {
                        if trees[[yy, x]]!.height >= thisH {
                            return Int(count + 1)
                        }
                        count += 1
                        yy += 1
                    }
                    return Int(count)
                }
                let visRight = {
                    var count = 0
                    var xx = x + 1
                    while xx < lines[0].count {
                        if trees[[y, xx]]!.height >= thisH {
                            return Int(count + 1)
                        }
                        xx += 1
                        count += 1
                    }
                    return Int(count)
                }
                let visLeft = {
                    var count = 0
                    var xx = x - 1
                    while xx >= 0 {
                        if trees[[y, xx]]!.height >= thisH {
                            return Int(count + 1)
                        }
                        xx -= 1
                        count += 1
                    }
                    return Int(count)
                }
                let thisSeen: Int = visUp() * visLeft() * visDown() * visRight()
                if thisSeen > MOSTSEEN {
                    MOSTSEEN = thisSeen
                }
            }
        }
        pr()
        pr(MOSTSEEN)
    }
    func Day7() {
        class fs {
            let name: String
            init(_ name: String) {
                self.name = name
            }
        }
        class file: fs {
            let size: Int
            init(_ name: String, _ size: Int) {
                self.size = size
                super.init(name)
            }
        }
        class dir: fs {
            var contents: [String: fs] = [:]
            let parent: dir?
            let isRoot: Bool
            var totalSize = 0 // calculated at end only

            init(_ name: String, _ parent: dir) {
                self.parent = parent
                isRoot = false
                super.init(name)
            }

            init(_ name: String, isRoot: Bool) {
                self.isRoot = true
                self.parent = nil
                super.init(name)
            }
        }

        func calcSize(_ cd: dir) -> Int {
            for (_, c) in cd.contents {
                if c is dir {
                    cd.totalSize += calcSize(c as! dir)
                } else {
                    cd.totalSize += (c as! file).size
                }
            }

            if cd.totalSize >= 8381165 && cd.totalSize < curSmallest {
                //            totalSum += cd.totalSize
                curSmallest = cd.totalSize
                pr("!!", cd.name, cd.totalSize, totalSum)
            }
            return cd.totalSize
        }


        func tryGoDir(_ newDir: String) {
            if curDir.contents[newDir] != nil {
                if curDir.contents[newDir] is file {
                    pr("ERROR", newDir)
                }
                else {
                    curDir = curDir.contents[newDir] as! dir
                }
            }
            else {
                curDir = tryMakeDir(newDir)
            }
        }

        func tryMakeDir(_ newDir: String) -> dir {
            if curDir.contents[newDir] == nil {
                curDir.contents[newDir] = dir(newDir, curDir)
            }
            return curDir.contents[newDir] as! dir
        }

        func tryMakeFile(_ newFile: String, _ size: String) -> file {
            if curDir.contents[newFile] == nil {
                curDir.contents[newFile] = file(newFile, Int(size)!)
            }
            return curDir.contents[newFile] as! file
        }

        let totalSum = 0
        var curSmallest = 999999999999999
        let rootDir: dir = .init("/", isRoot: true)
        var curDir: dir = .init("", isRoot: true)

        loadInput("day7")
        curDir = rootDir
        for l in input.components(separatedBy: "\n") {
            let toks = l.components(separatedBy: " ")
            if toks[0] == "$"
            {
                switch toks[1] {
                case "cd":
                    if toks[2] == ".." {
                        curDir = curDir.parent!
                    } else {
                        tryGoDir(toks[2])
                    }
                case "ls":
                    continue
                default:
                    pr("ERROR", l)
                    break
                }
            } else if toks[0] == "dir" {
                _ = tryMakeDir(toks[1])
            } else if l[0].isNumber {
                _ = tryMakeFile(toks[1], toks[0])
            } else {
                pr("ERROR", l)
            }
        }

        curDir = rootDir
        _ = calcSize(curDir)
        pr(curSmallest)
    }

    func Day6() {
        loadInput("day6")
        for i in 14...input.count {
            let last4 = input[i - 14..<i]
            let number_of_distinct = Set(last4).count

            if(number_of_distinct >= 14)
            {
                pr("yes")
                pr(last4)
                pr(i)
                return
            }
            else
            {
                //                pr("no")
                // no we don't have at least 7 unique chars.
            }
        }
    }

    func Day5() {
        loadInput("day5")
        let twoPartsIn = input.components(separatedBy: "\n\n")
        let stackCount = Int(twoPartsIn[0].components(separatedBy: "\n").last!.components(separatedBy: " ").last!)!
        var stacks = Array(repeating: [String].self(), count: stackCount)
        let startMap = twoPartsIn[0]
        for l in startMap.components(separatedBy: "\n") {
            for i in stride(from: 0, to: l.count, by: 4) {
                let thisChar = String(l[i + 1])
                if l[i + 1].isNumber || l[i + 1] == " " {
                    continue
                }
                stacks[(i) / 4].append(thisChar)
            }
        }
        let instructions = twoPartsIn[1]
        for l in instructions.components(separatedBy: .newlines) {
            let bits = l.components(separatedBy: " ")
            _ = Int(bits[1])!
            let startAmount = Int(bits[1])!
            let from = Int(bits[3])! - 1
            let to = Int(bits[5])! - 1
            var c = 0
            while c < startAmount {
                let a = stacks[from].remove(at: startAmount - c - 1)
                stacks[to].insert(a, at: 0)
                c += 1
            }
        }
        var output = ""
        for s in stacks {
            output += s[0]
        }
        pr(output)
    }

    func Day4() {
        loadInput("day4")
        var count = 0
        for l in input.components(separatedBy: .newlines) {
            let toks = l.components(separatedBy: ",")
            let a1 = Int(toks[0].components(separatedBy: "-")[0])!
            let a2 = Int(toks[0].components(separatedBy: "-")[1])!
            let a = Array(a1...a2)
            let b1 = Int(toks[1].components(separatedBy: "-")[0])!
            let b2 = Int(toks[1].components(separatedBy: "-")[1])!
            let b = Array(b1...b2)
            if a.filter({ x in b.contains(x) }).count > 0 || // a.count or b.count for part A
                b.filter({ x in a.contains(x) }).count > 0 {
                count += 1
            }
        }
        pr(count)
    }

    func Day3() {
        loadInput("day3")
        var sum = 0
        for l in input.components(separatedBy: "\n") {
            let line = Array(l)
            let first = line[0...l.count / 2 - 1]//.sorted()
            let second = line[l.count / 2...l.count - 1]//.sorted()
            let commonArray = first.filter { fruit in
                second.contains(fruit)
            }
            sum += commonArray[0].valDay3()
        }
        pr(sum)

        sum = 0
        let lines = input.components(separatedBy: "\n")
        for i in stride(from: 2, to: lines.count, by: 3) {
            let commonArray1 = lines[i].filter { fruit in
                lines[i - 1].contains(fruit)
            }.filter { fruit in
                lines[i - 2].contains(fruit)
            }
            sum += Array(commonArray1)[0].valDay3()
        }
        pr(sum)
    }

    func Day1() {
        loadInput("day1")
        let twoLines = input.components(separatedBy: "\n\n")
        var most = 0
        var sums: [Int] = []
        for a in twoLines {
            let s = a.components(separatedBy: "\n").compactMap { Int($0) }
            most = max (most, s.reduce(0, +))
            sums.append(s.reduce(0, +))
        }
        pr(most)
        pr(sums.sorted()[sums.count - 3 ... sums.count - 1].reduce(0, +))
    }

    func Day2() {
        loadInput("day2")

        var totalScore = 0
        for l in input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n") {
            let a = l.components(separatedBy: " ")[0]
            let b = l.components(separatedBy: " ")[1]
            //            pr(a)
            //            pr(b)
            switch a {
            case "A": //rock
                switch b {
                    // R 1, P 2, S 3
                case "X": //lose
                    totalScore += 3 + 0
                case "Y": //draw
                    totalScore += 1 + 3
                case "Z": //win
                    totalScore += 2 + 6
                default:
                    pr("ERRRR")
                }
            case "B": //paper
                switch b {
                case "X": //l
                    totalScore += 1 + 0
                case "Y": //d
                    totalScore += 2 + 3
                case "Z": //w
                    totalScore += 3 + 6
                default:
                    pr("ERRRR")
                }
            case "C": //scissor
                switch b {
                case "X": //l
                    totalScore += 2 + 0
                case "Y": //d
                    totalScore += 3 + 3
                case "Z": //w
                    totalScore += 1 + 6
                default:
                    pr("ERRRR")
                }
            default:
                pr("ERRRR")
            }
            //            pr(
            //X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win.
        }
        pr("asd")
        pr(totalScore)
    }
}
