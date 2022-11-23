//
//  CloseButtonView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import SwiftUI

struct CloseButtonView: View {
    @Binding var screen: Calculator.Screen
    
    var body: some View {
        Button {
            screen.close()
        } label: {
            Image(systemName: "xmark")
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView(screen: .constant(.settings))
    }
}
