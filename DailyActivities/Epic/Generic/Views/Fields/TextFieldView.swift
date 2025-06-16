//
//  TextFieldView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct TextFieldView: View {
    
    // MARK: Dependencies
    let placeholder: String
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    
    // MARK: Init
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    // MARK: - View
    var body: some View {
        TextField(placeholder, text: $text)
            .fontWithLineHeight(Fonts.Body.medium)
            .fullWidth(.leading)
            .padding(TKDesignSystem.Padding.regular)
            .roundedRectangleBorder(
                TKDesignSystem.Colors.Background.Theme.bg100,
                radius: TKDesignSystem.Radius.medium
            )
            .textFieldStyle(HideableTextField())
            .onTapGesture {
                isFocused = true
            }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var text: String = ""
    TextFieldView("Preview", text: $text)
        .preferredColorScheme(.dark)
}
