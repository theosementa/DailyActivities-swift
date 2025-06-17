//
//  CategoryRowView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct CategoryRowView: View {
    
    // MARK: Dependencies
    var category: CategoryEntity
    
    @State private var elapsedThisWeek: TimeInterval = .zero
    
    // MARK: - View
    var body: some View {
        HStack(spacing: TKDesignSystem.Spacing.medium) {
            Text(category.emoji)
                .font(.system(size: 24))
                .padding(12)
                .roundedRectangleBorder(
                    category.color,
                    radius: TKDesignSystem.Radius.small
                )
            
            VStack(alignment: .leading, spacing: TKDesignSystem.Spacing.extraSmall) {
                Text(category.name)
                    .fontWithLineHeight(Fonts.Body.medium)
                
                Text(elapsedThisWeek.asHoursMinutes)
                    .fontWithLineHeight(Fonts.Body.small)
                    .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
            }
            .fullWidth(.leading)
                        
            IconSVGView(icon: .iconChevronRight, value: .large)
        }
        .padding(TKDesignSystem.Padding.extraSmall)
        .roundedRectangleBorder(
            TKDesignSystem.Colors.Background.Theme.bg100,
            radius: TKDesignSystem.Radius.medium
        )
        .task {
            elapsedThisWeek = await elapsedThisWeek()
        }
    }
    
    func elapsedThisWeek() async -> TimeInterval {
        do {
            return try await ActivityRepository.fetchTimeThisWeek(for: category.id)
        } catch {
            print("⚠️ \(error.localizedDescription)")
            return .zero
        }
    }
}

// MARK: - Preview
#Preview {
    CategoryRowView(category: .preview)
        .padding()
        .preferredColorScheme(.dark)
}
