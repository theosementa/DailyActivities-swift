//
//  NavigationBarView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit
import NavigationKit

struct NavigationBarView: View {
    
    // MARK: Dependencies
    var title: String? = nil
    var withDismissButton: Bool = true
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: TKDesignSystem.Spacing.small) {
            HStack(spacing: TKDesignSystem.Spacing.small) {
                if withDismissButton {
                    NavigationDismissButton {
                        HStack(spacing: TKDesignSystem.Spacing.extraSmall) {
                            IconSVGView(icon: .iconArrowLeft, value: .medium)
                            
                            Text("word_back".localized)
                                .fontWithLineHeight(Fonts.Body.medium)
                        }
                        .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
                    }
                    .fullWidth(.leading)
                }
                
                Button {
                    
                } label: {
                    Text("word_create".localized)
                        .fontWithLineHeight(Fonts.Body.large)
                        .foregroundStyle(TKDesignSystem.Colors.Info.c500)
                }
                .fullWidth(.trailing)
            }
            
            if let title {
                Text(title)
                    .fontWithLineHeight(Fonts.Title.large)
            }
        }
        .padding(.horizontal, TKDesignSystem.Padding.large)
    }
}

// MARK: - Preview
#Preview {
    NavigationBarView(title: "Preview")
}
