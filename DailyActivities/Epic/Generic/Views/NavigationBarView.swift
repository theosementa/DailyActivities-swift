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
    var actionButton: ActionButton? = nil
    
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
                
                if let actionButton {
                    Button {
                        Task { await actionButton.action() }
                    } label: {
                        if let title = actionButton.title {
                            Text(title)
                        } else if let icon = actionButton.icon {
                            Image(icon)
                                .renderingMode(.template)
                        }
                    }
                    .fontWithLineHeight(Fonts.Body.large)
                    .foregroundStyle(actionButton.color)
                    .fullWidth(.trailing)
                }
            }
            
            if let title {
                Text(title)
                    .fontWithLineHeight(Fonts.Title.large)
            }
        }
        .padding(.horizontal, TKDesignSystem.Padding.large)
        .padding(.vertical, TKDesignSystem.Padding.small)
        .background(TKDesignSystem.Colors.Background.Theme.bg50)
    }
}

extension NavigationBarView {
    
    struct ActionButton {
        var icon: ImageResource? = nil
        var title: String? = nil
        var color: Color = TKDesignSystem.Colors.Info.c500
        var action: () async -> Void
    }
    
}

// MARK: - Preview
#Preview {
    NavigationBarView(title: "Preview")
}
