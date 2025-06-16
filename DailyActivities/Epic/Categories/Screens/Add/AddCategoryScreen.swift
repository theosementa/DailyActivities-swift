//
//  AddCategoryScreen.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct AddCategoryScreen: View {
    
    // MARK: States
    @State private var viewModel: ViewModel = .init()
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(title: "word_add_category".localized)
            
            ScrollView {
                VStack(spacing: TKDesignSystem.Spacing.large) {
                    HStack(spacing: TKDesignSystem.Spacing.medium) {
                        EmojiPickerView(emoji: $viewModel.emoji, width: viewModel.fieldHeight)
                        
                        TextFieldView("word_name".localized, text: $viewModel.name)
                            .fontWithLineHeight(Fonts.Body.large)
                            .getSize { fieldHeight in
                                self.viewModel.fieldHeight = fieldHeight.height
                            }
                    }
                }
                .padding(TKDesignSystem.Padding.large)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AddCategoryScreen()
        .preferredColorScheme(.dark)
}
