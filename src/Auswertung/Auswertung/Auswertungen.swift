//
//  Auswertungen.swift
//  Umfrage
//
//  Created by Noah Peeters on 27.02.18.
//  Copyright © 2018 Peeters. All rights reserved.
//

import Foundation

// MARK: - Gründe für private Nutzung
func privateReasons(rows: [[String]]) {
    let gründePrivat = rows.flatMap { (a: [String]) -> [String] in
        return a.gründePrivat.components(separatedBy: ",").map {
            $0.trimmingCharacters(in: CharacterSet(charactersIn: " -")).lowercased()
        }
    }

    let gründePrivatCount = gründePrivat.reduce(into: [:]) { counts, word in
        counts[categoriesPrivateReasons[word]!, default: 0] += 1
    }

    let gründePrivatCountSorted = Array(gründePrivatCount).sorted {
        $0.value > $1.value
    }

    print("Wort,Anteil\n" + gründePrivatCountSorted.map {
        "\($0.key),\(Double($0.value)/Double(rows.count))"
        }.joined(separator: "\n"))
}

func privateReasonsCategories() {
    var a: [String: [String]] = [:]
    Array(categoriesPrivateReasons).forEach { categoyMap in
        a[categoyMap.value, default: []] += [categoyMap.key]
    }

    let categories = Array(a).sorted {
        $0.key < $1.key
        }.map {
            ($0.key, $0.value.joined(separator: ", "))
    }

    print("\\begin{table}[h]\\begin{tabularx}{\\textwidth}{rX}")
    print("Kategorie & Begriffe \\\\")
    print("\\hline")
    for category in categories {
        print("\(category.0) & \\tiny \(category.1)\\\\")
    }
    print("\\end{tabularx}\\caption{Zuordnung der Begriffe des Freifeldes zu Kategorien}\\label{table:categories}\\end{table}")
}

// MARK: - Richtigkeit der Vorkenntnisse

func knowledgeCorrectniss(rows: [[String]]) {
    print("Vorkenntnisse,Ich kannte den Begriff nicht,Nein,Teilweise,Größtenteils,Ja")
    for pcKentnisse in 1..<7 {
        let filtered = rows.filter { $0.pcKentnisse == pcKentnisse }

        let count: [Int] = filtered.reduce([0,0,0,0,0]) {
            return [
                $0[0] + Int($1.vorkenntnisseRichtig == "Ja"),
                $0[1] + Int($1.vorkenntnisseRichtig == "Größtenteils"),
                $0[2] + Int($1.vorkenntnisseRichtig == "Teilweise"),
                $0[3] + Int($1.vorkenntnisseRichtig == "Nein"),
                $0[4] + Int($1.vorkenntnisseRichtig == "Ich kannte den Begriff nicht")
            ]
        }

        let mapped = count.map {
            String(Double($0)/Double(filtered.count))
        }.reversed().joined(separator: ",")

        print("\(pcKentnisse),\(mapped)")
    }
}

func knowledgeCorrectnessByUsageFreq(rows: [[String]]) {
    print("Vorkenntnisse,Ich kannte den Begriff nicht,Nein,Teilweise,Größtenteils,Ja")
    for häufig in 1..<5 {
        let filtered = rows.filter { $0.häufig == häufig }

        let count: [Int] = filtered.reduce([0,0,0,0,0]) {
            return [
                $0[0] + Int($1.vorkenntnisseRichtig == "Ja"),
                $0[1] + Int($1.vorkenntnisseRichtig == "Größtenteils"),
                $0[2] + Int($1.vorkenntnisseRichtig == "Teilweise"),
                $0[3] + Int($1.vorkenntnisseRichtig == "Nein"),
                $0[4] + Int($1.vorkenntnisseRichtig == "Ich kannte den Begriff nicht")
            ]
        }

        let mapped = count.map {
            String(Double($0)/Double(filtered.count))
            }.reversed().joined(separator: ",")

        print("\(häufig),\(mapped)")
    }
}

// MARK: - Gründe für kommerzielle Nutzung
func commercialReasoning(rows: [[String]]) {
    var voteCounts: [String: Int] = [:]
    rows.forEach() {
        $0.gründeUnternehmen.split(separator: ";").forEach {
            voteCounts[String($0), default: 0] += 1
        }
    }
    let sorted = voteCounts.sorted { $0.1 > $1.1 }
    let percentages = sorted.map {
        ($0.key, Double($0.value) / Double(rows.count))
    }

    let x = [["Kategorie", "Nutzer", "Unternehmen"]] + percentages.map {
        [$0.0, $0.1, 0.0]
    }

    x.forEach {
            print($0.map { String(describing: $0) }.joined(separator: ","))
    }
}

// MARK: - Vergleich private/gewerbliche Gründe
func privateVsUserCommercial(rows: [[String]]) {
    let gründePrivat = rows.flatMap { (a: [String]) -> [String] in
        return a.gründePrivat.components(separatedBy: ",").map {
            $0.trimmingCharacters(in: CharacterSet(charactersIn: " -")).lowercased()
        }
    }

    let gründePrivatCount = gründePrivat.reduce(into: [:]) { counts, word in
        counts[categoriesPrivateReasons[word]!, default: 0] += 1
    }

    var privateReasonsInCommercialCategories = privateToCommercialCategories.map() {
        return ($0.value, gründePrivatCount[$0.key]!)
    }.sorted {
        $0.1 > $1.1
    }

    let otherCount = gründePrivatCount.reduce(0) {
        if $1.key == "-" { return $0 }
        return privateToCommercialCategories[$1.key] == nil ? $0 + $1.value : $0
    }

    privateReasonsInCommercialCategories.append(("Sonstiges", otherCount))

    let commercialUserReasonsList = rows.flatMap {
        $0.gründeUnternehmen.components(separatedBy: ";")
    }

    let commercialUserReasons = commercialUserReasonsList.reduce(into: [:]) { counts, word in
        counts[word, default: 0] += 1
    }

    let comparisonPercentages = privateReasonsInCommercialCategories.map() {
        return (
            $0.0,
            Double($0.1) / Double(rows.count),
            Double(commercialUserReasons[$0.0, default: 0]) / Double(rows.count)
        )
    }

    print("Kategorie,Privat,Gewerblich")
    comparisonPercentages.forEach {
        print("\($0.0),\($0.1),\($0.2)")
    }
}

func privateVsCommercial(rows: [[String]]) {
    let gründePrivat = rows.flatMap { (a: [String]) -> [String] in
        return a.gründePrivat.components(separatedBy: ",").map {
            $0.trimmingCharacters(in: CharacterSet(charactersIn: " -")).lowercased()
        }
    }

    let gründePrivatCount = gründePrivat.reduce(into: [:]) { counts, word in
        counts[categoriesPrivateReasons[word]!, default: 0] += 1
    }

    let otherCount = gründePrivatCount.reduce(0) {
        if $1.key == "-" { return $0 }
        if privateToCommercialCategories[$1.key] == nil {
            print(($1.key, $1.value))
        }
        return privateToCommercialCategories[$1.key] == nil ? $0 + $1.value : $0
    }

    var commercialCategoryCount = privateToCommercialCategories.map() {
        return ($0.value, gründePrivatCount[$0.key]!)
    }.sorted {
            $0.1 > $1.1
    }

    commercialCategoryCount.append(("Sonstiges", otherCount))

    let commercialCategoryPercentage = commercialCategoryCount.map() {
        return [$0.0, Double($0.1) / Double(rows.count), commercialReasoningPercentages[$0.0, default: 0]]
    }

    ([["Kategorie", "Nutzer", "Unternehmen"]] + commercialCategoryPercentage).forEach {
        print($0.map { String(describing: $0) }.joined(separator: ","))
    }
}

// MARK: - Richtigkeit der Selbsteinschätzung
enum ProgramAffiliation {
    case using
    case notUsing
    case ignore
}

enum SoftwareToTakeIntoAccount {
    case OpenSource
    case Ignore
    case ClosedSource
}

extension Int {
    init(_ x: Bool) {
        self = x ? 1 : 0
    }
}

func reduceToCount(values: [UsageAndOSS], _ affiliation: ProgramAffiliation, _ programsToTakeIntoAccount: SoftwareToTakeIntoAccount) -> (Int, Int)? {
    let x = values.reduce((0, 0)) {
        switch programsToTakeIntoAccount {
        case .OpenSource:
            if !$1.isOpenSource { return $0 }
        case .ClosedSource:
            if $1.isOpenSource { return $0 }
        case .Ignore:
            break
        }

        switch affiliation {
        case .using:
            return ($1.using && $1.isGuessCorrect ? $0.0 + 1 : $0.0, Int($1.using) + $0.1)
        case .notUsing:
            return (!$1.using && $1.isGuessCorrect ? $0.0 + 1 : $0.0, Int(!$1.using) + $0.1)
        case .ignore:
            return ($1.isGuessCorrect ? $0.0 + 1 : $0.0, $0.1 + 1)
        }
    }

    return x.1 == 0 ? nil : x
}

func usesOSS(rows: [[String]], affiliation: ProgramAffiliation, programsToTakeIntoAccount: SoftwareToTakeIntoAccount = .Ignore) -> ([Double], [(Int, Int)]) {
    let correctnessByCategory: [[(Int, Int)?]] = rows.map {
        let browser = reduceToCount(values: $0.browser.values, affiliation, programsToTakeIntoAccount)
        let os = reduceToCount(values: $0.os.values, affiliation, programsToTakeIntoAccount)
        let web = reduceToCount(values: $0.webApp.values, affiliation, programsToTakeIntoAccount)
        let desktop = reduceToCount(values: $0.desktopApp.values, affiliation, programsToTakeIntoAccount)
        let games = reduceToCount(values: $0.games.values, affiliation, programsToTakeIntoAccount)

        return [browser, os, web, desktop, games]
    }

    let accumulatedCategoryCorrectness = correctnessByCategory.reduce([(0, 0), (0, 0), (0, 0), (0, 0), (0, 0)]) { categoriesCounter, categories in
        return zip(categories, categoriesCounter).map { category, categoryCounter in
            return ((category?.0 ?? 0) + categoryCounter.0, (category?.1 ?? 0) + categoryCounter.1)
        }
    }
    let accumulatedCategoryCorrectnessPercentage = accumulatedCategoryCorrectness.map {
        return Double($0.0) / Double($0.1)
    }

    let accumulatedCorrectness = accumulatedCategoryCorrectness.reduce((0, 0)) { categoryCorrectness, accumulatedCorrectness in
        return (categoryCorrectness.0 + accumulatedCorrectness.0, categoryCorrectness.1 + accumulatedCorrectness.1)
    }
    let accumulatedCorrectnessPercentage = Double(accumulatedCorrectness.0) / Double(accumulatedCorrectness.1)


    return (
        accumulatedCategoryCorrectnessPercentage + [accumulatedCorrectnessPercentage],
        accumulatedCategoryCorrectness + [accumulatedCorrectness]
    )
}

func usesOSSOverview(rows: [[String]]) {
    let correctnessPercentagesUsing = usesOSS(rows: rows, affiliation: .using).0
    let correctnessPercentagesUsageIgnored = usesOSS(rows: rows, affiliation: .ignore).0
    let correctnessPercentagesNotUsing = usesOSS(rows: rows, affiliation: .notUsing).0

    let categories = ["Browser", "OS", "Web", "Desktop", "Games", "Total"]

    let correctness =
        [["Category", "Using the program", "Usage ignored", "Not using the program"]] +
            zip(zip(zip(correctnessPercentagesUsing, correctnessPercentagesUsageIgnored), correctnessPercentagesNotUsing), categories).map {
                return [$1, $0.0.0, $0.0.1, $0.1]
    }

    correctness.forEach {
        print($0.map { String(describing: $0) }.joined(separator: ","))
    }
}

func usesOSSStackedOSSAndCSS(rows: [[String]]) {
    let correctnessUsingOpenSource = usesOSS(rows: rows, affiliation: .using, programsToTakeIntoAccount: .OpenSource).1
    let correctnessUsingClosedSource = usesOSS(rows: rows, affiliation: .using, programsToTakeIntoAccount: .ClosedSource).1

    let categories = ["Browser", "OS", "Web", "Desktop", "Games", "Total"]
    let x = zip(correctnessUsingOpenSource, correctnessUsingClosedSource).map { (arg) -> [Double] in
        let (oss, css) = arg
        let total = Double(oss.1 + css.1)
        let ossRight = Double(oss.0) / total
        let ossWrong = Double(oss.1 - oss.0) / total
        let cssRight = Double(css.0) / total
        let cssWrong = Double(css.1 - css.0) / total

        return [ossRight, cssRight, ossWrong, cssWrong]
    }

    print(["Kategorie", "OSS Richtig", "CSS Richtig", "OSS Falsch", "CSS Falsch"].joined(separator: ","))
    zip(categories, x).forEach {
        print("\($0),\($1.map { String($0) }.joined(separator: ","))")
    }
}

func usesOSSStackedOSS(rows: [[String]]) {
    let correctnessUsingOpenSource = usesOSS(rows: rows, affiliation: .using, programsToTakeIntoAccount: .OpenSource).1

    let categories = ["Browser", "OS", "Web", "Desktop", "Games", "Total"]
    let x = correctnessUsingOpenSource.map { oss -> [Double] in
        let ossRight = Double(oss.0) / Double(oss.1)
        let ossRightCount = Double(oss.0)
        let ossWrong = Double(oss.1 - oss.0) / Double(oss.1)
        let ossWrongCount = Double(oss.1 - oss.0)

        return [ossRight, ossWrong, ossRightCount, ossWrongCount]
    }

    print(["Kategorie", "OSS Richtig", "OSS Falsch"].joined(separator: ","))
    zip(categories, x).forEach {
        print("\($0),\($1.map { String($0) }.joined(separator: ","))")
    }
}
