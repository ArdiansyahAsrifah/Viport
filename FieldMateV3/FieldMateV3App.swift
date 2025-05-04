//
//  FieldMateV3App.swift
//  FieldMateV3
//
//  Created by Muhammad Ardiansyah Asrifah on 01/05/25.
//

import SwiftUI
import TipKit

@main
struct FieldMateV3App: App {
    init() {
            try? Tips.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
