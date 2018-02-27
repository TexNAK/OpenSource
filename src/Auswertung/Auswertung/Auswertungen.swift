//
//  Auswertungen.swift
//  Umfrage
//
//  Created by Noah Peeters on 27.02.18.
//  Copyright © 2018 Peeters. All rights reserved.
//

import Foundation

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

    let gründePrivatCount = gründePrivat.reduce(into: [:]) {
        counts, word in counts[gründePrivatCategories[word] ?? word, default: 0] += 1
    }

    let gründePrivatCountSorted = Array(gründePrivatCount).sorted {
        $0.value > $1.value
    }

    print("Wort,Count\n" + gründePrivatCountSorted.map {
        "\($0.key),\($0.value)"
        }.joined(separator: "\n"))
}

