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

let categoriesPrivateReasons = [
    "kostenlos": "Kosten",
    "sicherheit": "Sicherheit",
    "kosten": "Kosten",
    "günstig": "Kosten",
    "keine ahnung": "?",
    "": "?",
    "?": "?",
    "transparenz": "Transparenz",
    "community": "Community",
    "community\"\"": "Community",
    "anpassbar": "Anpassbarkeit",
    "sicher": "Sicherheit",
    "transparent": "Transparenz",
    "kostenfrei": "Kosten",
    "vertrauen": "Vertrauen",
    "gut": "Qualität",
    "praktisch": "Nützlich",
    "einfach": "Benutzerfreundlichkeit",
    "verfügbarkeit": "Verfügbarkeit",
    "unabhängig": "Unabhängigkeit",
    "anpassbarkeit": "Anpassbarkeit",
    "funktionalität": "Funktionalität",
    "unabhängigkeit": "Unabhängigkeit",
    "frei": "Frei",
    "funktioniert": "Qualität",
    "innovativ": "Innovation",
    "nix": "?",
    "qualität": "Qualität",
    "offen": "Transparenz",
    "freizugänglich": "Verfügbarkeit",
    "zufall": "Zufall",
    "meistens kostenlos": "Kosten",
    "gratis": "Kosten",
    "auswahl": "Auswahl",
    "free": "Kosten",
    "hilfreich": "Hilfreich",
    "preis": "Kosten",
    "...": "-",
    "sicherer": "Sicherheit",
    "nicht": "-",
    "verfügbar": "Verfügbarkeit",
    "nützlich": "Nützlich",
    "weiterentwicklung": "Weiterentwicklung",
    "wissentlich": "-",
    "benutzerindividuell": "Anpassbarkeit",
    "billig": "Kosten",
    "fast überall ist oss enthalten": "Indirekte Nutzung",
    "schön": "Benutzerfreundlichkeit",
    "leicht zugänglich": "Verfügbarkeit",
    "schnell": "Qualität",
    "privat": "-",
    "!": "-",
    "oft gute alternative": "Qualität",
    "keine großen konzerne unterstützen": "Anti-Kommerz",
    "ich": "-",
    "änderbar": "Code Veränderbarkeit",
    "innovation": "Innovation",
    "freiheit (fsf)": "Frei",
    "oft verbreitet": "Community",
    "offener quelltext": "Code Veränderbarkeit",
    "ich nicht": "-",
    "philosophie": "Grundeinstellung",
    "fehlerfreiheit": "Qualität",
    "und": "-",
    "meist kostenlos": "Kosten",
    "viel hilfestellung im internet": "Community",
    "toll": "Qualität",
    "weltanschauung": "Grundeinstellung",
    "moral": "Grundeinstellung",
    "variantenreich": "Anpassbarkeit",
    "sozial": "Community",
    "manchmal besser": "Qualität",
    "verständlich": "Benutzerfreundlichkeit",
    "ohne": "-",
    "oft besser": "Qualität",
    "anwendungsnutzen": "Benutzerfreundlichkeit",
    "überzeugung": "Grundeinstellung",
    "testversion": "Testversion",
    "anti-kommerz": "Anti-Kommerz",
    "es sie g": "-",
    "openess": "Frei",
    "veränderbar": "Code Veränderbarkeit",
    "unbewusst": "Unbewusste Nutzung",
    "gut zugänglich": "Verfügbarkeit",
    "handhabbar": "Benutzerfreundlichkeit",
    "weil software die ich brauche zufällig open-source ist": "Zufall",
    "datensicherheitt": "Datenschutz",
    "abeit": "Notwendig",
    "erweiterungen": "Anpassbarkeit",
    "unabhängig von herstellern": "Anti-Kommerz",
    "bla": "-",
    "erfahrung": "Erfahrung",
    "warum ist das hier pflichtfeld?": "-",
    "gewohnheit": "Erfahrung",
    "häufig kostenlos": "Kosten",
    "teilweise mehr funktionen als normale programme": "Funktionalität",
    "moralischer": "Grundeinstellung",
    "kompatibilität": "Kompatibilität",
    "fast genauso wie vergleichbare programme": "Qualität",
    "privatsphäre": "Datenschutz",
    "open source unterstützen": "Grundeinstellung",
    "notwendigkeit": "Notwendig",
    "anleitungen": "Community",
    "benutze": "-",
    "stable": "Qualität",
    "großer nutzenkreis": "Community",
    "communitydriven": "Community",
    "tue": "-",
    "meist ohne opensource": "-",
    "modell": "-",
    "frage": "-",
    "schnell verfügbar als download": "Verfügbarkeit",
    "blub": "-",
    "individuell": "Anpassbarkeit",
    "erprobt": "Erfahrung",
    "gutes konzept": "Innovation",
    "aktuell": "Qualität",
    "zuverlässig": "Qualität",
    "against microsoft": "Anti-Kommerz",
    "zielorientierung": "Qualität",
    "for free": "Kosten",
    "große entwickler gemeinschaft": "Entwickler Community",
    "meistens aktuell": "Qualität",
    "hat keinen speziellen grund": "Zufall",
    "\"\"schlechter\"\" als nicht open source": "Qualität",
    "offene standards": "Frei",
    "flexible": "Anpassbarkeit",
    "preiswert": "Kosten",
    "stabilität": "Qualität",
    "plattformunabhängig": "Qualität",
    "keine alternative": "Alternativlos",
    "verbreitet": "Community",
    "guter support/foren": "Community",
    "oft kostenlos": "Kosten",
    "..": "-",
    "funktionsbereitstellung": "Funktionalität",
    "schnellere sofwareentwicklung": "Entwickler Community",
    "kreativ": "Innovation",
    "umsonst": "Kosten",
    "freundlich zu bedienen": "Benutzerfreundlichkeit",
    "datenschutz": "Datenschutz",
    "communitysupport": "Community",
    "weil": "-",
    "kontrolle": "Anpassbarkeit",
    "alternativlos": "Alternativlos",
    "immer noch nicht verstanden was es ist": "-",
    "moderrn": "Benutzerfreundlichkeit",
    "erweiterbar": "Anpassbarkeit",
    "kostenersparnis": "Kosten",
    "open standard": "Frei",
    "einfach zu bekommen": "Verfügbarkeit",
    "quellcode": "Frei",
    "gute alternative": "Qualität",
    "updatefrequenz": "Entwickler Community",
    "weils funktioniert": "Funktionalität",
    "offen für eigene entwicklungen": "Anpassbarkeit",
    "kostengünstig": "Kosten",
    "besser": "Qualität",
    "transparant": "Transparenz",
    "demokratisch": "Community",
    "vielseitig": "Anpassbarkeit",
    "wurde empfohlen": "Community",
    "mit pacman installierbar": "Entwickler Community",
    "besser als kommerzielle sw": "Qualität",
    "schneller zugriff": "Verfügbarkeit",
    "kompatibel": "Kompatibilität",
    "\"\"sicher": "Sicherheit",
    "prinzip": "Grundeinstellung",
    "ibt": "-",
    "vertrauenswürdigkeit": "Datenschutz",
    "verifizierbar": "Frei",
    "zeitvertreib": "Anpassbarkeit",
    "keine geheimnisse": "Frei",
    "nutze": "-",
    "gutes gefühl": "Grundeinstellung",
    "keine gründe": "Zufall",
    "man kann selber eingreifen": "Anpassbarkeit",
    "kompatibler": "Anpassbarkeit",
    "verwaltung": "Benutzerfreundlichkeit",
    "arbeit": "Notwendig",
    "teilweisekostenfrei": "Kosten",
    "große community": "Community",
    "kostenvorteil": "Kosten",
    "teilw. besser": "Qualität",
    "freiheit": "Frei",
    "sympathisch": "Benutzerfreundlichkeit",
    "hilfee": "-",
    "vielfältigkeit": "Anpassbarkeit",
    "teilweise anbassbar": "Anpassbarkeit",
    "geht": "-",
    "jeder kann mitmachen": "Community",
    "komische": "-"
]