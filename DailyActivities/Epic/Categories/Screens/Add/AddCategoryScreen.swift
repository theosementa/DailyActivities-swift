//
//  AddCategoryScreen.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct AddCategoryScreen: View {
    
    // MARK: Environments
    @Environment(CategoryStore.self) private var categoryStore
    @Environment(\.dismiss) private var dismiss
    
    // MARK: States
    @State private var viewModel: ViewModel = .init()
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(
                title: "word_add_category".localized,
                actionButton: .init(
                    title: "word_create".localized,
                    action: {
                        await categoryStore.create(viewModel.categoryEntity)
                        dismiss()
                    }
                )
            )
            
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
                    
                    ColorPickerView(
                        selectedColor: $viewModel.color,
                        colorWidth: self.viewModel.fieldHeight
                    )
                }
                .padding(TKDesignSystem.Padding.large)
            }
        }
        .background(TKDesignSystem.Colors.Background.Theme.bg50)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Preview
#Preview {
    AddCategoryScreen()
        .preferredColorScheme(.dark)
}
