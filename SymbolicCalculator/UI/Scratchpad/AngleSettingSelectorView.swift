//
//  AngleSettingSelectorView.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/2/22.
//

import SwiftUI

struct AngleSettingSelectorView: View {
    @Binding var setting: AngleSetting
    
    var body: some View {
        Text(setting.string)
            .font(.caption)
            .onTapGesture { setting.toggle() }
    }
}

struct AngleModeSelectorView_Previews: PreviewProvider {
    struct AngleModeSelectorView_PreviewProvider: View {
        @State var setting = AngleSetting.deg
        
        var body: some View {
            AngleSettingSelectorView(setting: $setting)
        }
    }
    
    static var previews: some View {
        AngleModeSelectorView_PreviewProvider()
            .padding(100)
    }
}
