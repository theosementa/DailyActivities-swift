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
    
    // MARK: - View
    var body: some View {
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

// MARK: - Preview
#Preview {
    ActionButtonView(title: "Preview", backgroundColor: .blue)
        .padding()
}
