//
//  CalculatorView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var calc: Calculator
    
    var body: some View {
        ZStack {
            if calc.screen == .home {
                HomeView()
            }
            if calc.screen == .scratchpad {
                ScratchpadView()
            }
            if calc.screen == .file {
                Text("file")
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    struct CalculatorView_PreviewProvider: View {
        @StateObject var calc = Calculator(scratchpad: Scratchpad(currentPage: .calculator, rows: [ComputationRow(index: 0, input: "7.0")]))
        var body: some View {
            CalculatorView()
        }
    }
    
    static var previews: some View {
        CalculatorView_PreviewProvider()
    }
}
