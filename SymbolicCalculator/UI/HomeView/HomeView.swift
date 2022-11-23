//
//  HomeView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import SwiftUI

struct HomeView: View {
    static let columns =
    [
        Column(0, title: "Scratchpad", rows: [
            Row(0, "a", "Calculate", .scratchpad),
            Row(1, "b", "Graph", .scratchpad)
        ]),
        Column(1, title: "Documents", rows: [
            Row(0, "1", "New", .file),
            Row(1, "2", "Browse", .file),
            Row(2, "3", "Recent", .file),
            Row(3, "4", "Current", .file),
            Row(4, "5", "Settings...", .settings)
        ])
    ]
    
    @EnvironmentObject var calculator: Calculator
    @State var selection = (-1, -1)
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView()
            HomeOptionsView(screen: $calculator.screen, selection: $selection, columns: HomeView.columns)
                .foregroundColor(Color.white)
            Spacer()
            BottomIcons()
            Spacer()
                .frame(height: 10)
        }
            .frame(width: 320, height: 240)
            .clipped()
            .background(Color.black)
            .onAppear {
                calculator.buttonBindings = ArrowsNoBindings()
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    struct HomeView_PreviewProvider: View {
        @StateObject var calc = Calculator()
        
        var body: some View {
            HomeView()
        }
    }
    
    static var previews: some View {
        HomeView_PreviewProvider()
    }
}
