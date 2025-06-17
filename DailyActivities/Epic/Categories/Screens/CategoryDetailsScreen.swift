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
    @Environment(ActivityStore.self) private var activityStore
    
    @State var viewModel = SessionActivityViewModel()
    
    // MARK: Computed
    var category: CategoryEntity? {
        return CategoryStore.shared.findOneById(categoryId)
    }
    
    @State private var isPrinting = false
    @State private var timer: Timer? = nil
    
    // MARK: - View
    var body: some View {
        if let category {
            VStack {
                Text("Current session")
                HStack {
                    Text(String(format: "%02d:%02d", Int(viewModel.elapsedTime) / 60, Int(viewModel.elapsedTime) % 60))
                }

                ForEach(category.activities) { activity in
                    if activity.endDate == nil {
                        Text(activity.startDate, style: .timer)
                    }
                }
            }
            
            Button {
                Task {
                    await activityStore.create(.init(category: category))
                    startPrint()
                }
            } label: {
                Text("Start a session")
            }
            
            Button {
                let notEndedActivities = category.activities.filter { $0.endDate == nil }
                if let first = notEndedActivities.first {
                    first.endDate = Date()
                    finishPrint()
                    do {
                        try activityStore.repository.context.save()
                    } catch {
                        print("⚠️ \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("End session")
            }

        }
    }
    
    
    
    func startPrint() {
        isPrinting = true
        
        viewModel.sessionName = category?.name ?? ""
        viewModel.sessionEmoji = category?.emoji ?? ""

//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            viewModel.elapsedTime += 1
//            viewModel.updateLiveActivity()
//        }
        
        // Start Live Activity
        viewModel.startLiveActivity()
    }
    
    func cancelPrint() {
        timer?.invalidate()
        timer = nil
        isPrinting = false
        
        // End Live Activity
        viewModel.endLiveActivity()
    }
    
    func finishPrint() {
        timer?.invalidate()
        timer = nil
        isPrinting = false
        
        // End Live Activity with success
        viewModel.endLiveActivity(success: true)
    }
    
    
}

// MARK: - Preview
#Preview {
    CategoryDetailsScreen(categoryId: CategoryEntity.preview.id)
}
