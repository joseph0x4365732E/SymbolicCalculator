//
//  Scratchpad.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import Foundation
import SwiftUI
import SymbolicCalculus

struct Scratchpad {
    enum Page {
        case calculator
        case graph
        
        var imageName: String { self == .calculator ? "candybarphone" : "chart.line.uptrend.xyaxis" }
        var borderColor: Color { self == .calculator ? Color.gray : Color.blue }
    }
    
    var currentPage: Page
    var angleSetting: AngleSetting = .deg
    var rows: [ComputationRow<AnyScalar>] = []
    var input: String = ""
    var selection = (x: 0, y: 0)
    var typingSelected: Bool { selection.y == rows.count }
    var typingIndex: Int { rows.count }
    
    init(currentPage: Page, angleSetting: AngleSetting = .deg, rows: [ComputationRow<AnyScalar>] = [], input: String = "", selection: (x: Int, y: Int) = (x: 0, y: 0)) {
        self.currentPage = currentPage
        self.angleSetting = angleSetting
        self.rows = rows
        self.input = input
        self.selection = selection
    }
    
    mutating func submitInput() {
        guard !input.isEmpty else { return }
        
        rows.append(ComputationRow<AnyScalar>(index: rows.count, input: input))
        if typingSelected { selection.y += 1 }
        input = ""
    }
    
    mutating func upArrow() { selection.y = max(0, selection.y - 1) }
    mutating func downArrow() { selection.y = min(typingIndex, selection.y + 1) }
    mutating func leftArrow() { selection.x = min(0, selection.x - 1) }
    mutating func rightArrow() { selection.x = max(1, selection.x + 1) }
}
