//
//  const.swift
//  Umfrage
//
//  Created by Noah Peeters on 27.02.18.
//  Copyright © 2018 Peeters. All rights reserved.
//

import Foundation

struct UsageAndOSS {
    let using: Bool
    let guessedOpenSource: Bool
    let isOpenSource: Bool

    var isGuessCorrect: Bool { return guessedOpenSource == isOpenSource }

    init(_ cell: String, _ isOpenSource: Bool) {
        using = cell.contains("Benutze ich")
        guessedOpenSource = cell.contains("Open Source")
        self.isOpenSource = isOpenSource
    }
}

protocol UsageAndOSSProvider {
    var values: [UsageAndOSS] { get }
}

struct Browser: UsageAndOSSProvider {
    let safari: UsageAndOSS
    let chrome: UsageAndOSS
    let opera: UsageAndOSS
    let firefox: UsageAndOSS
    let chromium: UsageAndOSS

    var values: [UsageAndOSS] { return [safari, chrome, opera, firefox, chromium] }
}

struct OperatingSystems: UsageAndOSSProvider {
    let windows: UsageAndOSS
    let linux: UsageAndOSS
    let iOS: UsageAndOSS
    let macOS: UsageAndOSS
    let android: UsageAndOSS

    var values: [UsageAndOSS] { return [windows, linux, iOS, macOS, android] }
}

struct WebApp: UsageAndOSSProvider {
    let ownCloud: UsageAndOSS
    let moodle: UsageAndOSS
    let wikipedia: UsageAndOSS

    var values: [UsageAndOSS] { return [ownCloud, moodle, wikipedia] }
}

struct DesktopApp: UsageAndOSSProvider {
    let vlc: UsageAndOSS
    let photoshop: UsageAndOSS
    let msOffice: UsageAndOSS
    let latex: UsageAndOSS
    let sevenZip: UsageAndOSS
    let wmPlayer: UsageAndOSS
    let thunderbird: UsageAndOSS
    let gimp: UsageAndOSS
    let openOffice: UsageAndOSS
    let winRar: UsageAndOSS

    var values: [UsageAndOSS] { return [vlc, photoshop, msOffice, latex, sevenZip, wmPlayer, thunderbird, gimp, openOffice, winRar] }
}

struct Games: UsageAndOSSProvider {
    let worldOfWarcraft: UsageAndOSS
    let superhot: UsageAndOSS
    let firewatch: UsageAndOSS
    let skyrim: UsageAndOSS
    let counterStrike: UsageAndOSS
    let farCry: UsageAndOSS
    let subnautica: UsageAndOSS
    let assassinsCreed: UsageAndOSS
    let portal: UsageAndOSS
    let leagueOfLegends: UsageAndOSS
    let halfLife: UsageAndOSS

    var values: [UsageAndOSS] { return [worldOfWarcraft, superhot, firewatch, skyrim, counterStrike, farCry, subnautica, assassinsCreed, portal, leagueOfLegends, halfLife] }
}

extension Array where Element == String {
    var timestamp: String { return self[0] }
    var vorkenntnisseRichtig: String { return self[1] }
    var häufig: String { return self[2] }
    var browser: Browser {
        return Browser(
            safari: UsageAndOSS(self[3], true),
            chrome: UsageAndOSS(self[4], true),
            opera: UsageAndOSS(self[5], true),
            firefox: UsageAndOSS(self[6], true),
            chromium: UsageAndOSS(self[7], true))
    }
    var os: OperatingSystems {
        return OperatingSystems(
            windows: UsageAndOSS(self[8], false),
            linux: UsageAndOSS(self[9], true),
            iOS: UsageAndOSS(self[10], false),
            macOS: UsageAndOSS(self[11], false),
            android: UsageAndOSS(self[12], true))
    }
    var webApp: WebApp {
        return WebApp(
            ownCloud: UsageAndOSS(self[13], true),
            moodle: UsageAndOSS(self[14], true),
            wikipedia: UsageAndOSS(self[15], true))
    }
    var desktopApp: DesktopApp {
        return DesktopApp(
            vlc: UsageAndOSS(self[16], true),
            photoshop: UsageAndOSS(self[17], false),
            msOffice: UsageAndOSS(self[18], false),
            latex: UsageAndOSS(self[19], true),
            sevenZip: UsageAndOSS(self[20], true),
            wmPlayer: UsageAndOSS(self[21], false),
            thunderbird: UsageAndOSS(self[22], true),
            gimp: UsageAndOSS(self[23], true),
            openOffice: UsageAndOSS(self[24], true),
            winRar: UsageAndOSS(self[25], false))
    }
    var games: Games {
        return Games(
            worldOfWarcraft: UsageAndOSS(self[26], false),
            superhot: UsageAndOSS(self[27], true),
            firewatch: UsageAndOSS(self[28], true),
            skyrim: UsageAndOSS(self[29], false),
            counterStrike: UsageAndOSS(self[30], true),
            farCry: UsageAndOSS(self[31], false),
            subnautica: UsageAndOSS(self[32], true),
            assassinsCreed: UsageAndOSS(self[33], false),
            portal: UsageAndOSS(self[34], true),
            leagueOfLegends: UsageAndOSS(self[35], false),
            halfLife: UsageAndOSS(self[36], true))
    }
    var gründePrivat: String { return self[37] }
    var gründeUnternehmen: String { return self[38] }
    var tätigkeit: String { return self[39] }
    var pcKentnisse: Int { return Int(self[40])! }
}

let gründePrivatCategories = [
    "kostenlos": "Kosten",
    "sicherheit": "Sicherheit",
    "kosten": "Kosten",
    "günstig": "Kosten",
    "keine ahnung": "?",
    "": "?",
    "transparenz": "Transparenz",
    "community": "Community",
    "anpassbar": "Anpassbarkeit",
    "sicher": "Sicherheit",
    "transparent": "Transparenz",
    "kostenfrei": "Kosten",
    "vertrauen": "Vertrauen",
    "gut": "Qualität",
    "praktisch": "Praktisch",
    "einfach": "Benutzerfreundlichkeit",
    "verfügbarkeit": "Verfügbarkeit",
    "unabhängig": "Unabhängigkeit",
    "anpassbarkeit": "Anpassbarkeit",
    "funktionalität": "Funktionalität",
    "unabhängigkeit": "Unabhängigkeit",
    "frei": "Frei",
    "funktioniert": "Qualität",
    "innovativ": "Innovativ",
    "nix": "?",
    "qualität": "Qualität",
    "offen": "Transparenz",
    "freizugänglich": "Verfügbarkeit",
    "zufall": "Grundlos",
    "meistens kostenlos": "Kosten",
    "gratis": "Kosten",
    "auswahl": "Auswahl",
    "free": "Kosten",
    "hilfreich": "Hilfreich",
    "preis": "Kosten",
    "...": "?",
    "sicherer": "Sicherheit",
    "nicht": "-",
    "verfügbar": "Verfügbarkeit",
    "nützlich": "Nützlich",
    "weiterentwicklung": "Weiterentwicklung",
    "wissentlich": "-",
    "benutzerindividuell": "Anpassbar",
    "billig": "Kosten",
    "fast überall ist oss enthalten": "Indirekte Nutzung",
    "schön": "Benutzerfreundlichkeit",
    "leicht zugänglich": "Verfügbarkeit",
    "schnell": "Qualität",
    "privat": "Privat",
    "!": "-",
    "oft gute alternative": "Alternative",
    "keine großen konzerne unterstützen": "Anti-Kommerz"
]
