//
//  ArrowBindings.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import Foundation

protocol ArrowBindings {
    func upArrow()
    func downArrow()
    func leftArrow()
    func rightArrow()
}

struct ArrowsNoBindings: ArrowBindings {
    func upArrow() {}
    func downArrow() {}
    func leftArrow() {}
    func rightArrow() {}
}

struct ScratchpadBindings: ArrowBindings {
    unowned var calculator: Calculator
    func upArrow() { calculator.scratchpad.upArrow() }
    func downArrow() { calculator.scratchpad.downArrow() }
    func leftArrow() { calculator.scratchpad.leftArrow() }
    func rightArrow() { calculator.scratchpad.rightArrow() }
}
