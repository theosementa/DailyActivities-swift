//
//  ActivityStore.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation

@Observable @MainActor
final class ActivityStore {
    static let shared = ActivityStore()
    let repository = ActivityRepository()
    
    private init() { }
    
    private(set) var activities: [ActivityEntity] = []
}

extension ActivityStore {
    
    func fetchAll(for categoryId: UUID) async {
        do {
            self.activities = try await repository.fetchActivities(for: categoryId)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func create(_ activity: ActivityEntity) async {
        do {
            try repository.insert(activity)
            self.activities.append(activity)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
//    func update(_ activity: ActivityEntity) async {
//        do {
//            
//        }
//    }
    
    func delete(_ activity: ActivityEntity) async {
        do {
            try repository.delete(activity)
            self.activities.removeAll { $0.id == activity.id }
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
        
    
}
