//
//  Column.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import Foundation

struct Column {
    var index: Int
    var title: String
    var rows: [Row]
    
    init(_ index: Int, title: String, rows: [Row]) {
        self.index = index
        self.title = title
        self.rows = rows
    }
}
