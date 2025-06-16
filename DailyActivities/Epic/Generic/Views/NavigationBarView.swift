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
    var withDismissButton: Bool = true
    
    // MARK: - View
    var body: some View {
        VStack {
            if withDismissButton {
                NavigationDismissButton {
                    HStack(spacing: TKDesignSystem.Spacing.extraSmall) {
                        IconSVGView(icon: .iconArrowLeft, value: .medium)
                        
                        Text("word_back".localized)
                            .font(TKDesignSystem.Fonts.Body.medium)
                    }
                    .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
                }
                .fullWidth(.leading)
            }
            
            Button {
                
            } label: {
                Text("word_create".localized)
                    .font(TKDesignSystem.Fonts.Body.large)
                    .foregroundStyle(TKDesignSystem.Colors.Info.c500)
            }
            .fullWidth(.trailing)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationBarView()
        .applyDesignSystem()
}
