//
//  ColumnView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import SwiftUI

struct ColumnView: View {
    var column: Column
    @Binding var screen: Calculator.Screen
    @Binding var selection: (Int, Int)
    
    var thisColumnSelected: Bool { selection.0 == column.index }
    
    func rowView(row: Row) -> some View {
        return Button {
            selection.0 = column.index
            selection.1 = row.index
            screen = row.screen
        } label: {
            Text(row.displayText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.opacity(0.0001))
            .padding(.horizontal, 4.0)
            .if(thisColumnSelected && row.index == selection.1) { conditionalView in
                conditionalView.background(Color.blue)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .keyboardShortcut(KeyEquivalent(row.shortcut), modifiers: [])
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(column.title)
                .font(.headline)
            ForEach(column.rows, id: \.index) { row in
                rowView(row: row)
            }
        }
        .frame(width: 140, alignment: .leading)
    }
}

struct ColumnView_Previews: PreviewProvider {
    struct ColumnView_PreviewProvider: View {
        let column =
        Column(0, title: "Scratchpad", rows: [
            Row(0, "a", "Calculate", .scratchpad),
            Row(1, "b", "Graph", .scratchpad)
        ])
        
        @State var calculator = Calculator()
        @State var selection = (0, 0)
        
        var body: some View {
            ColumnView(column: column, screen: $calculator.screen, selection: $selection)
                .foregroundColor(Color.white)
                .background(Color.black)
        }
    }
    
    static var previews: some View {
        ColumnView_PreviewProvider()
    }
}
