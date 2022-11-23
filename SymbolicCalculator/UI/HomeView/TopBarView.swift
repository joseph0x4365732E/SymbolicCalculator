//
//  TopBarView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/1/22.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        HStack {
            Group {
                Image(systemName: "house")
                Spacer()
                Text("CAS")
                Spacer()
                Image(systemName: "battery.100")
            }
            .padding(4.0)
        }
        .font(.headline)
        .foregroundColor(Color.white)
        .background(Color.gray.opacity(0.3))
        .frame(height: 20)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
