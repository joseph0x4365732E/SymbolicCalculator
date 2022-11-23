//
//  Calculator.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import Foundation

class Calculator: ObservableObject {
    enum Screen {
        case home
        case scratchpad
        case file
        case settings
        
        mutating func close() { self = .home }
    }
    
    @Published var scratchpad: Scratchpad = Scratchpad(currentPage: .calculator)
    @Published var screen: Screen = .home
    @Published var buttonBindings: any ArrowBindings = ArrowsNoBindings()
    
    init(scratchpad: Scratchpad = Scratchpad(currentPage: .calculator), screen: Screen = .home, buttonBindings: ArrowBindings = ArrowsNoBindings()) {
        self.scratchpad = scratchpad
        self.screen = screen
        self.buttonBindings = buttonBindings
    }
    
    var scratchpadBinding: ScratchpadBindings {
        ScratchpadBindings(calculator: self)
    }
}
