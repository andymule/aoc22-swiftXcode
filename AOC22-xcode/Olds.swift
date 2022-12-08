extension Mine {
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

        var totalSum = 0
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
