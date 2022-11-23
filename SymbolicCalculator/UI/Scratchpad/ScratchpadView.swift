//
//  ScratchPadView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import SwiftUI

struct ScratchpadView: View {
    @EnvironmentObject var calc: Calculator
    @FocusState var focus: ScratchPadFocus?
    
    enum ScratchPadFocus {
        case typing
        case copying
    }

    var body: some View {
        VStack(spacing: 0) {
            ScratchpadTopBarView()
                .frame(width: 320, height: 20)
            ScrollView {
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 3)
                    ForEach(calc.scratchpad.rows, id: \.index) { row in
                        ComputationRowView(selection: $calc.scratchpad.selection, computation: row)
                            .padding(.horizontal, 4)
                            .frame(height: 34)
                    }
                    ScrollView(.horizontal) {
                        TextField("", text: $calc.scratchpad.input)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onSubmit {
                                calc.scratchpad.submitInput()
                            }
                            .padding(.horizontal, 6.5)
                            .frame(width: 100, height: 34)
                            .focused($focus, equals: .typing)
                            .onAppear {
                                focus = .typing
                            }
                    }
                }
            }
            .background(Color.white)
        }
        .onAppear {
            calc.buttonBindings = calc.scratchpadBinding
        }
        .environment(\.colorScheme, .light)
    }
}

struct ScratchPadView_Previews: PreviewProvider {
    struct ScratchPadView_PreviewProvider: View {
        @StateObject var calc = Calculator(scratchpad: Scratchpad(currentPage: .calculator, rows: [
//            ComputationRow(index: 0, input: "7.0"),
//            ComputationRow(index: 1, input: "8.0"),
//            ComputationRow(index: 2, input: "9.0")
        ]))
        var body: some View {
            ScratchpadView()
                .environmentObject(calc)
                .frame(width: 320, height: 240)
        }
    }
    
    static var previews: some View {
        ScratchPadView_PreviewProvider()
    }
}
