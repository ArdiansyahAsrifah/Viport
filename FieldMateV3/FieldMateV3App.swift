//
//  FieldMateV3App.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 01/05/25.
//

import SwiftUI
import TipKit
import AppIntents


@main
struct FieldMateV3App: App {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                   speechRecognizer: speechRecognizer,
                   date: Date(),
                   report: parseReport(from: speechRecognizer.summaryText) 
               )
        }
        
    }
    
    
    func parseReport(from text: String) -> MaintenanceReport {
        func extract(_ key: String) -> String {
            let pattern = "\(key):\\s*(.*?)(\\n|$)"
            if let range = text.range(of: pattern, options: .regularExpression) {
                let line = text[range]
                if let colonIndex = line.firstIndex(of: ":") {
                    return String(line[line.index(after: colonIndex)...]).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            return "-"
        }

        return MaintenanceReport(
            lokasi: extract("lokasi"),
            kerusakan: extract("kerusakan"),
            akibat: extract("akibat"),
            tindakan: extract("tindakan")
        )
    }

}




