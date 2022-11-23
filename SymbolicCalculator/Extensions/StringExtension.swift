//
//  StringExtension.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/6/22.
//

import Foundation
import SymbolicCalculus

extension Character {
    var isConstantPunctuation: Bool { return self == "/" || self == "." }
}

extension String {
    func starts(with substring: String) -> Bool {
        guard !substring.isEmpty else { return false }
        return self.prefix(substring.count) == substring
    }
    
    func ends(with substring: String) -> Bool {
        guard !substring.isEmpty else { return false }
        return self.suffix(substring.count) == substring
    }
    
    var leadingExpression: ExpressionString {
        let result = ExpressionString.allStringable.filter { exprStr in
            starts(with: exprStr.string)
        }
        guard result.count <= 1 else { fatalError("Too many results (\(result.count)). Results: \(result)") }
        if result.count == 1 { return result.first! }
        if startsWithNumber { return .constant(string: leadingNumber) }
        if startsWithContainerOpening {
            let container = leadingContainer
            if !container.isEmpty { return .expression(eType: .container(contents: container)) }
        }
        return .other
    }
    
    mutating func dropLeadingExpression() -> ExpressionString {
        let result = leadingExpression
        switch result {
        case .expression(eType: .container(contents: let contents)):
            self.removeFirst(contents.count + 1)
            if first == ")" { removeFirst() }
            return result
        default: break
        }
            
        self.removeFirst(result.string.count)
        return result
    }
    
    var trailingExpression: ExpressionString {
        let result = ExpressionString.allStringable.filter { exprStr in
            ends(with: exprStr.string)
        }
        guard result.count <= 1 else { fatalError("Too many results (\(result.count)). Results: \(result)") }
        if result.count == 1 { return result.first! }
        if endsWithNumber { return .constant(string: trailingNumber) }
        return .other
    }
    
    var startsWithContainerOpening: Bool { first == "(" || first == "," }
    
    var leadingContainer: String {
        guard startsWithContainerOpening else { return "" } // must have count of at least 1
        var parenthesisCount = 1
        var charCount = 0
        let firstRemoved = self.suffix(count - 1)
        outerLoop: for char in firstRemoved {
            switch char {
            case "(": parenthesisCount += 1
            case ")": parenthesisCount -= 1
            case ",": if parenthesisCount == 1 {
                parenthesisCount = 0
                break outerLoop
            }
            default: break
            }
            if parenthesisCount == 0 { break outerLoop }
            charCount += 1
        }
        guard parenthesisCount == 0 else { return "" }
        return String(firstRemoved.prefix(charCount))
    }
    
    mutating func dropLeadingContainer() -> String {
        var container = leadingContainer
        guard !container.isEmpty else { return "" }
        self.removeFirst(container.count + 1)
        if first == ")" { removeFirst() }
        return container
    }
    
    var startsWithNumber: Bool {
        guard let firstChar = first else { return false }
        if firstChar.isNumber { return true }
        guard firstChar == "." else { return false }
        if (count > 1) && self[index(after: startIndex)].isNumber { return true }
        return false
    }
    
    var endsWithNumber: Bool {
        guard let lastChar = last else { return false }
        if lastChar.isNumber { return true }
        guard lastChar == "." else { return false }
        if (count > 1) && self[index(before: endIndex)].isNumber { return true }
        return false
    }
    
    var leadingNumber: String {
        guard startsWithNumber else { return "" }
        var numberOfDigits = 0
        var foundConstantPunctuation = false
        for char in self {
            if char.isConstantPunctuation {
                if foundConstantPunctuation { break }
                foundConstantPunctuation = true
            } else {
                guard char.isNumber else { break }
            }
            numberOfDigits += 1
        }
        return String(prefix(numberOfDigits))
    }
    
    var trailingNumber: String {
        guard endsWithNumber else { return "" }
        var numberOfDigits = 0
        var foundConstantPunctuation = false
        for char in reversed() {
            if char.isConstantPunctuation {
                if foundConstantPunctuation { break }
                foundConstantPunctuation = true
            } else {
                guard char.isNumber else { break }
            }
            numberOfDigits += 1
        }
        return String(suffix(numberOfDigits))
    }
    
    mutating func dropLeadingNumber() -> String {
        let leading = leadingNumber
        self.removeLast(leading.count)
        return leading
    }
    
    mutating func dropTrailingNumber() -> String {
        let trailing = trailingNumber
        self.removeLast(trailing.count)
        return trailing
    }
}

extension Array {
    mutating func dropLast() -> Element {
        let result = last!
        self.removeLast()
        return result
    }
}
