//
//  ActionButtonView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 19/06/2025.
//

import SwiftUI
import TheoKit

struct ActionButtonView: View {
    
    // MARK: Dependencies
    let title: String
    let backgroundColor: Color
    var action: () async -> Void
    
    // MARK: - View
    var body: some View {
        Button {
            Task {
                await action()
            }
        } label: {
            Text(title)
                .fontWithLineHeight(Fonts.Body.large)
                .foregroundStyle(.white)
                .fullWidth()
                .padding(TKDesignSystem.Padding.medium)
                .background {
                    RoundedRectangle(cornerRadius: TKDesignSystem.Radius.medium, style: .continuous)
                        .fill(LinearGradient(autoGradientForColor: backgroundColor.toHex()))
                }
        }

    }
}

// MARK: - Preview
#Preview {
    ActionButtonView(title: "Preview", backgroundColor: .blue) { }
        .padding()
}
