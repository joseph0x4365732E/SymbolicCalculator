//
//  ComputationRowView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import SwiftUI
import SymbolicCalculus

struct ComputationRowView<S: Scalar>: View {
    @Binding var selection: (x: Int, y: Int)
    var computation: ComputationRow<S>
    
    var backgroundColor: Color {
        computation.index.isMultiple(of: 2) ? Color.white : Color.windowBackgroundColor
    }
    var rowSelected: Bool { selection.y == computation.index }
    var leftSelected: Bool { (selection.x == 0) && rowSelected }
    var rightSelected: Bool { (selection.x == 1) && rowSelected }
    
    func selectRow() { selection.y = computation.index }
    func selectLeft() { selectRow(); selection.x = 0 }
    func selectRight() { selectRow(); selection.x = 1 }
    
    struct SelectableText: View {
        var str: String
        var selected: Bool
        var alignment: Alignment
        
        
        var body: some View {
            Text(str)
                .padding(2.5)
                .if(selected) {
                    $0.background(Color.blue.opacity(0.5))
            }
                .frame(maxWidth: .infinity, alignment: alignment)
                .background(Color.black.opacity(0.0001))
        }
    }
    
    var body: some View {
        HStack {
            SelectableText(str: computation.input, selected: leftSelected, alignment: .leading)
                .onTapGesture { selectLeft() }
            Spacer()
            SelectableText(str: computation.output, selected: rightSelected, alignment: .trailing)
                .onTapGesture { selectRight() }
        }
        .background(backgroundColor)
    }
}

struct ComputationRowView_Previews: PreviewProvider {
    static var previews: some View {
        ComputationRowView<AnyScalar>(selection: .constant((0,0)), computation: ComputationRow(index: 0, input: "7.0"))
    }
}
