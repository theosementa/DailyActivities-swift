//
//  HideableTextField.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//


import SwiftUI

struct HideableTextField: TextFieldStyle {
    @FocusState var isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .focused($isFocused)
            .toolbar {
                if (isFocused) {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Divider()
                            Button {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            } label: {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                        }
                    }
                }
            }
    }
}
