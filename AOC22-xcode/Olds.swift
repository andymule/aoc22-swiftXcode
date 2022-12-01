extension Mine {
    func Day1() {
        loadInput("day1")
        var twoLines = input.components(separatedBy: "\n\n")
        var most = 0
        var sums:[Int] = []
        for a in twoLines {
            var s = a.components(separatedBy: "\n").compactMap { Int($0) }
            most = max (most, s.reduce(0, +))
            sums.append(s.reduce(0, +))
        }
        pr(most)
        pr(sums.sorted()[sums.count-3 ... sums.count-1].reduce(0, +))
    }
}
