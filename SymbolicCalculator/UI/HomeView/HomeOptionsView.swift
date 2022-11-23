//
//  HomeOptionsView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/4/22.
//

import SwiftUI

struct HomeOptionsView: View {
    @Binding var screen: Calculator.Screen
    @Binding var selection: (Int, Int)
    var columns: [Column]
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(columns, id: \.index) { column in
                ColumnView(column: column, screen: $screen, selection: $selection)
                    .padding(10.0)
            }
        }
    }
}

struct HomeOptionsView_Previews: PreviewProvider {
    struct HomeOptionsView_PreviewProvider: View {
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
        
        @State var calculator = Calculator()
        @State var selection = (0, 0)
        
        var body: some View {
            HomeOptionsView(screen: $calculator.screen, selection: $selection, columns: HomeView.columns)
                .foregroundColor(Color.white)
                .background(Color.black)
        }
    }
    
    static var previews: some View {
        HomeOptionsView_PreviewProvider()
    }
}
