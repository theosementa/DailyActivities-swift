//
//  ActivityRowView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 17/06/2025.
//

import SwiftUI
import TheoKit

struct ActivityRowView: View {
    
    // MARK: Depencencies
    var activity: ActivityEntity
    
    // MARK: Environment
    @Environment(ActivityStore.self) private var activityStore
    @Environment(SessionActivityManager.self) private var sessionManager
    
    // MARK: - View
    var body: some View {
        if let category = activity.category {
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
                    Text("session_of".localized + " \(category.name)")
                        .fontWithLineHeight(Fonts.Body.medium)
                   
                    Text(activity.duration.asHoursMinutes)
                        .fontWithLineHeight(Fonts.Body.small)
                        .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
                }
                .fullWidth(.leading)
            }
            .padding(TKDesignSystem.Padding.extraSmall)
            .roundedRectangleBorder(
                TKDesignSystem.Colors.Background.Theme.bg100,
                radius: TKDesignSystem.Radius.medium
            )
            .contentShape(
                .contextMenuPreview,
                RoundedRectangle(cornerRadius: TKDesignSystem.Radius.medium, style: .continuous)
            )
            .contextMenu {
                AsyncButtonView(role: .destructive) {
                    await activityStore.delete(activity)
                } label: {
                    Label(
                        title: { Text("word_delete") },
                        icon: { IconSVGView(icon: .iconTrash, value: .medium) }
                    )
                }
            } preview: {
                self
                    .frame(width: UIScreen.main.bounds.width - TKDesignSystem.Padding.large * 2)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ActivityRowView(activity: .preview)
}
