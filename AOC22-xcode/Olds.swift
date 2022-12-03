extension Mine {
    func Day3() {
        loadInput("day3")
        var sum = 0
        for l in input.components(separatedBy: "\n") {
            let line = Array(l)
            var first = line[0...l.count / 2 - 1]//.sorted()
            var second = line[l.count / 2...l.count - 1]//.sorted()
            let commonArray = first.filter { fruit in
                second.contains(fruit)
            }
            sum += val(String(commonArray[0]))
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
            sum += val(String(Array(commonArray1)[0]))
        }
        pr(sum)
    }

    func val(_ str: String) -> Int {
        var returnVal = Int(Character(str).asciiValue!)
        if returnVal >= 97 {
            returnVal -= 70 + 26
        } else {
            returnVal -= 64 - 26
        }

        return returnVal
    }

    func Day1() {
        loadInput("day1")
        var twoLines = input.components(separatedBy: "\n\n")
        var most = 0
        var sums: [Int] = []
        for a in twoLines {
            var s = a.components(separatedBy: "\n").compactMap { Int($0) }
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
            var a = l.components(separatedBy: " ")[0]
            var b = l.components(separatedBy: " ")[1]
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
