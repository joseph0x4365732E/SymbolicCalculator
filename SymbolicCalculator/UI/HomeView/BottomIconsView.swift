//
//  SwiftUIView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import SwiftUI

struct BottomIcons: View {
    func calculatorIcon() -> some View {
        func calcQuarter(imageName: String) -> some View {
            return HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image(systemName: imageName)
                    Spacer()
                }
                Spacer()
            }
            .frame(width: 8, height: 8)
        }
        
        return VStack {
            HStack {
                calcQuarter(imageName: "multiply")
                calcQuarter(imageName: "divide")
            }
            HStack {
                calcQuarter(imageName: "plus")
                calcQuarter(imageName: "minus")
            }
        }
        .frame(width: 36, height: 36)
        //.aspectRatio(1.0, contentMode: .fill)
        .background(Color.gray)
        .cornerRadius(5)
    }
    
    func oneSymbolIcon<b: View>(imageName: String, background: b) -> some View {
            Image(systemName: imageName)
                .imageScale(.large)
                //.aspectRatio(1.0, contentMode: .fill)
                .frame(width: 36, height: 36)
                .background(background)
                .cornerRadius(5)
    }
    
    var body: some View {
        HStack {
            Group {
                calculatorIcon()
                oneSymbolIcon(imageName: "chart.line.uptrend.xyaxis", background: Color.cyan)
                oneSymbolIcon(imageName: "triangle", background: Color.blue)
                oneSymbolIcon(imageName: "squareshape.split.3x3", background: Color.teal.overlay(Color.green.opacity(0.3)))
                oneSymbolIcon(imageName: "chart.bar", background: Color.pink)
                oneSymbolIcon(imageName: "doc.plaintext", background: Color.orange)
                oneSymbolIcon(imageName: "lightbulb", background: Color.green)
            }
        }
        //.padding(40)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BottomIcons()
            //.frame(width: 100)
    }
}
