//
//  AngleSetting.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import Foundation

enum AngleSetting {
    case deg
    case rad
    var string: String { self == .deg ? "DEG" : "RAD" }
    var opposite: AngleSetting { self == .deg ? .rad : .deg }
    mutating func toggle() { self = opposite }
}
