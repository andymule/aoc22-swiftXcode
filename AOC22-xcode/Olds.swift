extension Mine {
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
            var amount = Int(bits[1])!
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
