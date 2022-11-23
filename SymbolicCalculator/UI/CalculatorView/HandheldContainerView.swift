//
//  HandheldContainerView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import SwiftUI

struct HandheldContainerView: View {
    @StateObject var calc = Calculator(scratchpad: Scratchpad(currentPage: .calculator, rows: []), screen: .scratchpad)
    
    var body: some View {
        VStack(spacing: 25) {
            CalculatorView()
                .environmentObject(calc)
                .frame(width: 320, height: 240)
            ArrowsView(keyBindings: $calc.buttonBindings)
        }
        .padding(50)
        .background(.ultraThinMaterial)
    }
}

struct ScreenContainerView_Previews: PreviewProvider {
    static var previews: some View {
        HandheldContainerView()
    }
}
