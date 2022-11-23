//
//  ActivatableTextField.swift
//  SymbolicCalculator
//
//  Created by Joseph Cestone on 9/5/22.
//

import SwiftUI

struct ActivatableTextField: NSViewRepresentable {
    
    @Binding var text: String
    @Binding var firstResponder: Bool
//    var previouslyFirstResponder: Bool
//    mutating func didUpdate() { previouslyFirstResponder = firstResponder }
//
//    var shouldUpdateResponder: Bool { firstResponder != previouslyFirstResponder }
    
    class CustomNSTextField: NSTextField {
        var coordinator: Coordinator { delegate as! Coordinator }
        
        override func textDidChange(_ notification: Notification) {
            coordinator.text = stringValue
            super.textDidChange(notification)
        }
        
        override func resignFirstResponder() -> Bool {
            return super.resignFirstResponder()
        }
    }
    
    class Coordinator: NSObject, NSTextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
//            self._firstResponder = firstResponder
//            self.previouslyFirstResponder = firstResponder.wrappedValue
        }
        
        func controlTextDidEndEditing(_ obj: Notification) {
            #warning("finish this")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    func makeNSView(context: Context) -> some NSView {
        let field = CustomNSTextField()
        field.delegate = context.coordinator
        return field
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        if firstResponder {
            nsView.becomeFirstResponder()
        } else {
            nsView.resignFirstResponder()
        }
    }
}

struct ActivatableTextField_Previews: PreviewProvider {
    struct ActivatableTextField_PreviewProvider: View {
        @State var text = "test"
        @State var firstResponder = false
        
        var body: some View {
            VStack {
                ActivatableTextField(text: $text, firstResponder: $firstResponder)
                Text(text)
                Button {
                    firstResponder.toggle()
                } label: {
                    Text("first responder")
                }

            }
            .padding()
        }
    }
    
    static var previews: some View {
        ActivatableTextField_PreviewProvider()
    }
}
