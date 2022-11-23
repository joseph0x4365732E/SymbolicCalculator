//
//  SymbolicCalculatorApp.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    
    /// After Launch, customize the window to be transparent (ultrathin configured in Symbol\_SelectorApp)
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.toolbarStyle = .expanded
            window.isOpaque = false
            window.titlebarAppearsTransparent = true
            window.backgroundColor = NSColor.clear
            window.delegate = self
        }
    }
}

@main
struct SymbolicCalculatorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            HandheldContainerView()
        }
    }
}
