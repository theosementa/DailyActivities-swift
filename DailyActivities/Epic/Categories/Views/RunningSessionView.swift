//
//  RunningSessionView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 19/06/2025.
//

import SwiftUI
import TheoKit

struct RunningSessionView: View {
    
    // MARK: Dependencies
    var activity: ActivityEntity
    
    // MARK: Environment
    @Environment(ActivityStore.self) private var activityStore
    @Environment(SessionActivityManager.self) private var sessionManager
    
    // MARK: State
    @State private var actionButtonHeight: CGFloat = 0
    
    // MARK: - View
    var body: some View {
        VStack(spacing: TKDesignSystem.Spacing.standard) {
            if let category = activity.category {
                Text(category.emoji)
                    .font(.system(size: 24))
                    .shadow(radius: 4, y: 4)
                    .padding(12)
                    .roundedRectangleBorder(
                        category.color,
                        radius: TKDesignSystem.Radius.small
                    )
            }
            
            Text("session_underway".localized)
                .fontWithLineHeight(Fonts.Title.medium)
            
            Text(activity.startDate, style: .relative)
                .fontWithLineHeight(Fonts.Body.small)
                .foregroundStyle(TKDesignSystem.Colors.Background.Theme.bg600)
            
            HStack(spacing: TKDesignSystem.Spacing.medium) {
                ActionButtonView(title: "end_session", backgroundColor: .red) {
                    if let currentSession = activityStore.activities.first(where: { $0.endDate == nil }) {
                        currentSession.endDate = Date()
                        activityStore.currentActivity = nil
                        sessionManager.endLiveActivity()
                        do {
                            try activityStore.repository.context.save()
                        } catch {
                            print("⚠️ \(error.localizedDescription)")
                        }
                    }
                }
                .getSize { size in
                    self.actionButtonHeight = size.height
                }
                
                IconSVGView(icon: .iconXmark, value: .large)
                    .foregroundStyle(Color.label)
                    .frame(width: actionButtonHeight, height: actionButtonHeight)
                    .roundedRectangleBorder(
                        TKDesignSystem.Colors.Background.Theme.bg200,
                        radius: TKDesignSystem.Radius.medium
                    )
            }
        }
        .padding(TKDesignSystem.Padding.medium)
        .roundedRectangleBorder(
            TKDesignSystem.Colors.Background.Theme.bg100,
            radius: TKDesignSystem.Radius.medium
        )
    }
}

// MARK: - Preview
#Preview {
    RunningSessionView(activity: .preview)
}
