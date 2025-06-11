//
//  TestShortcutApp.swift
//  TestShortcut
//
//  Created by Daud Mujib on 11/06/2025.
//

import SwiftUI

@main
struct TestShortcutApp: App {
    
    init() {
        TestShortcuts.updateAppShortcutParameters()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
