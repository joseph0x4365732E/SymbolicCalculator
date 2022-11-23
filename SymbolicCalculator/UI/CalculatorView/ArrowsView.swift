//
//  ArrowsView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import SwiftUI

struct ArrowsView: View {
    @Binding var keyBindings: ArrowBindings
    
    var body: some View {
        VStack {
            Button(action: { keyBindings.upArrow() }, label: {Image(systemName: "arrowtriangle.up.fill")})
                .keyboardShortcut(KeyEquivalent.upArrow, modifiers: [])
            Spacer()
            HStack {
                Button(action: { keyBindings.leftArrow() }, label: {Image(systemName: "arrowtriangle.left.fill")})
                    .keyboardShortcut(KeyEquivalent.leftArrow, modifiers: [])
                Spacer()
                Button(action: { keyBindings.rightArrow() }, label: {Image(systemName: "arrowtriangle.right.fill")})
                    .keyboardShortcut(KeyEquivalent.rightArrow, modifiers: [])
            }
            Spacer()
            Button(action: { keyBindings.downArrow() }, label: {Image(systemName: "arrowtriangle.down.fill")})
                .keyboardShortcut(KeyEquivalent.downArrow, modifiers: [])
        }
        .foregroundColor(.white)
        .padding(4)
        .imageScale(.large)
        .buttonStyle(PlainButtonStyle())
        .frame(width: 100, height: 100)
        .background(.black)
        .cornerRadius(10)
    }
}

struct ArrowsView_Previews: PreviewProvider {
    struct ArrowsView_PreviewProvider: View {
        @State var calc = Calculator()
        
        var body: some View {
            ArrowsView(keyBindings: $calc.buttonBindings)
        }
    }
    
    static var previews: some View {
        ArrowsView_PreviewProvider()
    }
}
