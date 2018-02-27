//
//  Auswertungen.swift
//  Umfrage
//
//  Created by Noah Peeters on 27.02.18.
//  Copyright © 2018 Peeters. All rights reserved.
//

import Foundation

// MARK: - Gründe für private Nutzung: Categories

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
    print("\\end{tabularx}\\end{table}")
}

// MARK: - Gründe für private Nutzung
func test(rows: [[String]]) {
    let filteredRows = rows//.filter {
    //    $0.pcKentnisse != 4
    //}
    let gründePrivat = filteredRows.flatMap { (a: [String]) -> [String] in
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

    print("Wort,Count\n" + gründePrivatCountSorted.map {
        "\($0.key),\($0.value)"
        }.joined(separator: "\n"))
}

// MARK: - Richtigkeit der Selbsteinschätzung
enum ProgramAffiliation {
    case using
    case notUsing
    case ignore
}

extension Int {
    init(_ x: Bool) {
        self = x ? 1 : 0
    }
}

func reduceToCount(values: [UsageAndOSS], _ affiliation: ProgramAffiliation) -> (Int, Int)? {
    let x = values.reduce((0, 0)) {
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

func usesOSS(rows: [[String]], affiliation: ProgramAffiliation) -> [Double] {
    let correctnessByCategory: [[(Int, Int)?]] = rows.map {
        let browser = reduceToCount(values: $0.browser.values, affiliation)
        let os = reduceToCount(values: $0.os.values, affiliation)
        let web = reduceToCount(values: $0.webApp.values, affiliation)
        let desktop = reduceToCount(values: $0.desktopApp.values, affiliation)
        let games = reduceToCount(values: $0.games.values, affiliation)

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

    return accumulatedCategoryCorrectnessPercentage + [accumulatedCorrectnessPercentage]
}

func usesOSSOverview(rows: [[String]]) {
    let correctnessPercentagesUsing = usesOSS(rows: rows, affiliation: .using)
    let correctnessPercentagesUsageIgnored = usesOSS(rows: rows, affiliation: .ignore)
    let correctnessPercentagesNotUsing = usesOSS(rows: rows, affiliation: .notUsing)

    let categories = ["Browser", "OS", "Web", "Desktop", "Games", "Total"]

    let correctness =
        [["Category", "Using the program", "Usage ignored", "Not using the program"]] +
            zip(zip(zip(correctnessPercentagesUsing, correctnessPercentagesUsageIgnored), correctnessPercentagesNotUsing), categories).map {
                return [$1, $0.0.0 * 100, $0.0.1 * 100, $0.1 * 100]
    }

    correctness.forEach {
        print($0.map { String(describing: $0) }.joined(separator: ","))
    }
}
