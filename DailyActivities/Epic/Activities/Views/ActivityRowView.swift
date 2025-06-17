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
    
    // MARK: - View
    var body: some View {
        if let category = activity.category {
            HStack(spacing: TKDesignSystem.Spacing.medium) {
                Text(category.emoji)
                    .font(.system(size: 24))
                    .padding(12)
                    .roundedRectangleBorder(
                        category.color,
                        radius: TKDesignSystem.Radius.small
                    )
                
                VStack(alignment: .leading, spacing: TKDesignSystem.Spacing.extraSmall) {
                    Text("word_session_of".localized + " \(category.name)")
                        .fontWithLineHeight(Fonts.Body.medium)
                    
                    Group {
                        if activity.endDate == nil {
                            Text(activity.startDate, style: .relative)
                        } else {
                            Text(activity.duration.asHoursMinutes)
                        }
                    }
                    .fontWithLineHeight(Fonts.Body.small)
                    .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
                }
                .fullWidth(.leading)
                
                Button {
                    Task { await activityStore.delete(activity) }
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(Color.red)
                }
            }
            .padding(TKDesignSystem.Padding.extraSmall)
            .roundedRectangleBorder(
                TKDesignSystem.Colors.Background.Theme.bg100,
                radius: TKDesignSystem.Radius.medium
            )
        }
    }
}

// MARK: - Preview
#Preview {
    ActivityRowView(activity: .preview)
}
