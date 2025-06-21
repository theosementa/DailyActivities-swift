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
    var categoryId: UUID
    
    // MARK: Environment
    @Environment(CategoryStore.self) private var categoriesStore
    
    var category: CategoryModel? {
        return categoriesStore.findOneById(categoryId)
    }
        
    // MARK: - View
    var body: some View {
        if let category {
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
    }
    
    func elapsedThisWeek() async {
        guard var category else { return }
        
        do {
            let elapsedTime = try await ActivityRepository.fetchTimeThisWeek(for: category.id)
            category.elapsedTimeThisWeek = elapsedTime
            categoriesStore.updateLocaly(category)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
}

// MARK: - Preview
#Preview {
    CategoryRowView(categoryId: CategoryModel.preview.id)
        .padding()
        .preferredColorScheme(.dark)
}
