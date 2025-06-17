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
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            Task {
                                let newActivity: ActivityEntity = .init(categoryId: category.id)
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
                                .fullWidth()
                                .background(Color.blue, in: .rect(cornerRadius: 12))
                        }
                        
                        Button {
                            if let currentSession = activityStore.activities.first(where: { $0.endDate == nil }) {
                                currentSession.endDate = Date()
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
                                .fullWidth()
                                .background(Color.red, in: .rect(cornerRadius: 12))
                        }
                    }
                    
                    if let currentSession = activityStore.activities.first(where: { $0.endDate == nil }) {
                        ActivityRowView(activity: currentSession)
                            .padding(.bottom, 32)
                    } else {
                        Text("No active session")
                    }
                    
                    ForEach(activityStore.activities.filter { $0.endDate != nil }) { activity in
                        ActivityRowView(activity: activity)
                    }
                }
                .padding(24)
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
