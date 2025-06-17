//
//  CategoryDetailsScreen.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI

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
            VStack {
                VStack {
                    ForEach(activityStore.activities) { activity in
                        if activity.endDate == nil {
                            Text(activity.startDate, style: .timer)
                        }
                    }
                }
                
                Button {
                    Task {
                        let newActivity: ActivityEntity = .init(category: category)
                        await activityStore.create(newActivity)
                        sessionManager.startLiveActivity(
                            sessionName: category.name,
                            sessionEmoji: category.emoji,
                            sessionColorHex: category.colorHex
                        )
                    }
                } label: {
                    Text("Start a session")
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.blue, in: .rect(cornerRadius: 12))
                }
                
                Button {
                    let notEndedActivities = activityStore.activities.filter { $0.endDate == nil }
                    if let first = notEndedActivities.first {
                        first.endDate = Date()
                        sessionManager.endLiveActivity()
                        do {
                            try activityStore.repository.context.save()
                        } catch {
                            print("⚠️ \(error.localizedDescription)")
                        }
                    }
                } label: {
                    Text("End session")
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.red, in: .rect(cornerRadius: 12))
                }
            }
            .onViewDidLoad {
                await activityStore.fetchAll(for: categoryId)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CategoryDetailsScreen(categoryId: CategoryEntity.preview.id)
}
