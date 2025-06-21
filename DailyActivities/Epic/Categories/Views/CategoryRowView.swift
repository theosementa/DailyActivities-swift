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
        
    // MARK: - View
    var body: some View {
        HStack(spacing: TKDesignSystem.Spacing.medium) {
            Text(category.emoji)
                .font(.system(size: 24))
                .shadow(radius: 4, y: 4)
                .padding(12)
                .roundedRectangleBorder(
                    category.color,
                    radius: TKDesignSystem.Radius.small
                )
            
            VStack(alignment: .leading, spacing: TKDesignSystem.Spacing.extraSmall) {
                Text(category.name)
                    .fontWithLineHeight(Fonts.Body.medium)
                    .foregroundStyle(Color.label)
                
                Text(category.elapsedTimeThisWeek.asHoursMinutes)
                    .fontWithLineHeight(Fonts.Body.small)
                    .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
            }
            .fullWidth(.leading)
                        
            IconSVGView(icon: .iconChevronRight, value: .large)
                .foregroundStyle(Color.label)
                .padding(.trailing, TKDesignSystem.Padding.medium)
        }
        .padding(TKDesignSystem.Padding.extraSmall)
        .roundedRectangleBorder(
            TKDesignSystem.Colors.Background.Theme.bg100,
            radius: TKDesignSystem.Radius.medium
        )
        .task {
            await elapsedThisWeek()
        }
    }
    
    func elapsedThisWeek() async {
        do {
            self.category.elapsedTimeThisWeek = try await ActivityRepository.fetchTimeThisWeek(for: category.id)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
}

// MARK: - Preview
#Preview {
    CategoryRowView(category: .preview)
        .padding()
        .preferredColorScheme(.dark)
}
