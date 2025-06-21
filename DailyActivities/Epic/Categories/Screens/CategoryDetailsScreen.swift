//
//  CategoryDetailsScreen.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct CategoryDetailsScreen: View {
    
    // MARK: Dependencies
    var categoryId: UUID
    
    // MARK: Environments
    @Environment(SessionActivityManager.self) private var sessionManager
    @Environment(ActivityStore.self) private var activityStore
    
    // MARK: Computed
    var category: CategoryEntity? {
        return CategoryStore.shared.findOneById(categoryId)
    }
    
    // MARK: - View
    var body: some View {
        if let category {
            VStack(spacing: 0) {
                NavigationBarView()
                
                ScrollView {
                    if let currentSession = activityStore.currentActivity {
                        RunningSessionView(activity: currentSession)
                            .padding(.bottom, 32)
                    } else {
                        ActionButtonView(title: "start_session".localized, backgroundColor: .blue) {
                            let newActivity: ActivityEntity = .init(categoryId: category.id)
                            await activityStore.create(newActivity)
                            sessionManager.startLiveActivity(
                                sessionName: category.name,
                                sessionEmoji: category.emoji,
                                sessionColorHex: category.colorHex
                            )
                        }
                        .padding(.bottom, 32)
                    }
                                        
                    let filteredActivities = activityStore.activities
                        .filter { $0.endDate != nil }
                        .sorted { $0.endDate! > $1.endDate! }
                    VStack(spacing: TKDesignSystem.Spacing.medium) {
                        ForEach(filteredActivities) { activity in
                            ActivityRowView(activity: activity)
                        }
                    }
                }
                .animation(.smooth, value: sessionManager.isSessionRunning)
                .contentMargins(TKDesignSystem.Padding.large)
                .background(TKDesignSystem.Colors.Background.Theme.bg50)
                .onViewDidLoad {
                    await activityStore.fetchAll(for: categoryId)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

// MARK: - Preview
#Preview {
    CategoryDetailsScreen(categoryId: CategoryEntity.preview.id)
}
