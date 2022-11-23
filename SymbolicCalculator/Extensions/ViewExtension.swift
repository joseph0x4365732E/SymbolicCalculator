//
//  ViewExtension.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import Foundation
import SwiftUI

// From https://www.avanderlee.com/swiftui/conditional-view-modifier/
extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension Color {
    static let systemBlue = Color(NSColor.systemBlue)
    static let systemGreen = Color(NSColor.systemGreen)
    static let systemIndigo = Color(NSColor.systemIndigo)
    static let systemOrange = Color(NSColor.systemOrange)
    static let systemPink = Color(NSColor.systemPink)
    static let systemPurple = Color(NSColor.systemPurple)
    static let systemRed = Color(NSColor.systemRed)
    static let systemTeal = Color(NSColor.systemTeal)
    static let systemYellow = Color(NSColor.systemYellow)
    static let windowBackgroundColor = Color(NSColor.windowBackgroundColor)
    static let notSelectedColor = Color(NSColor.underPageBackgroundColor)
}
