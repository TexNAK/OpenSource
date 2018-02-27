//
//  const.swift
//  Umfrage
//
//  Created by Noah Peeters on 27.02.18.
//  Copyright © 2018 Peeters. All rights reserved.
//

import Foundation

extension Array where Element == String {
    var timestamp: String { return self[0] }
    var vorkenntnisseRichtig: String { return self[1] }
    var häufig: String { return self[2] }
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
