//
//  main.swift
//  Umfrage
//
//  Created by Noah Peeters on 27.02.18.
//  Copyright © 2018 Peeters. All rights reserved.
//

import Foundation

func printHelp() {
    print("Usage: \(CommandLine.arguments[0]) <path> to input csv")
}

guard CommandLine.arguments.count == 2 else {
    printHelp()
    exit(1)
}

guard let inputString = try? String(contentsOf: URL(fileURLWithPath: CommandLine.arguments[1])) else {
    printHelp()
    print("Cannot open \"\(CommandLine.arguments[1])\"")
    exit(1)
}

let csv = CSwiftV(with: inputString)
let rows = csv.rows

usesOSSStackedOSS(rows: rows.filter {
    $0.pcKentnisse > 4
})
//privateReasons(rows: rows)
//privateReasonsCategories()
//usesOSSOverview(rows: rows)
//knowledgeCorrectniss(rows: rows)
//usesOSSOverview(rows: rows.filter {
//    $0.pcKentnisse > 4
//})
//commercialReasoning(rows: rows)

