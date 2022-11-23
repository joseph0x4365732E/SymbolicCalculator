//
//  Row.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import Foundation

struct Row {
    var index: Int
    var shortcut: Character
    var verbatim: String
    var screen: Calculator.Screen
    
    init(_ index: Int, _ shortcut: Character, _ verbatim: String, _ screen: Calculator.Screen) {
        self.index = index
        self.shortcut = shortcut
        self.verbatim = verbatim
        self.screen = screen
    }
    
    var displayText:  String { String(shortcut).uppercased() + " " + verbatim }
}
