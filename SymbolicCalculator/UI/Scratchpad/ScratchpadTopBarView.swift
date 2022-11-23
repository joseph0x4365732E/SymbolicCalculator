//
//  ScratchpadTopBarView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/6/22.
//

import SwiftUI

struct ScratchpadTopBarView: View {
    @EnvironmentObject var calc: Calculator
    
    struct TabView: View {
        var page: Scratchpad.Page
        @Binding var currentPage: Scratchpad.Page
        var active: Bool { currentPage == page }
        
        var backgroundColor: Color { active ? Color.white : Color.notSelectedColor }
        var borderColor: Color { active ? page.borderColor : Color.gray }
        
        var body: some View {
            Image(systemName: page.imageName)
                .imageScale(.small)
                .padding(1)
                .frame(width: 40, height: 22)
                .background(
                    backgroundColor
                        .border(borderColor)
                        .padding(.top, 4)
                )
                .if(!active) { view in
                    view.overlay(
                        currentPage.borderColor.frame(height: 3)
                            .offset(y: 8.5)
                    )
                }
                .onTapGesture { currentPage = page }
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(calc.scratchpad.currentPage.borderColor)
                .frame(height: 3)
                .offset(y: 8.5)
            Group {
                HStack(spacing: 0) {
                    Group {
                        TabView(page: .calculator, currentPage: $calc.scratchpad.currentPage)
                        TabView(page: .graph, currentPage: $calc.scratchpad.currentPage)
                        Text("Scratchpad")
                            .frame(width: 90)
                            .offset(y: -1)
                            .font(.headline)
                        Spacer()
                        AngleSettingSelectorView(setting: $calc.scratchpad.angleSetting)
                            .offset(y: -0.5)
                        Image(systemName: "battery.100")
                            .offset(y: -1)
                            .padding(.horizontal, 4)
                        CloseButtonView(screen: $calc.screen)
                            .offset(y: -1)
                    }
                }
                .padding(4.0)
                .foregroundColor(Color.black)
                .frame(height: 20)
            .clipped()
            }
        }
        .background(Color.windowBackgroundColor)
    }
}

struct ScratchpadTopBarView_Previews: PreviewProvider {
    
    struct ScratchpadTopBarView_PreviewProvider: View {
        @State var calc = Calculator()
        
        var body: some View {
            ScratchpadTopBarView()
                .environmentObject(calc)
        }
    }
    
    static var previews: some View {
        ScratchpadTopBarView_PreviewProvider()
    }
}
