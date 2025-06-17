//
//  ActivityRepository.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
final class ActivityRepository: GenericRepository<ActivityEntity> { }

extension ActivityRepository {
    
    func fetchActivities(for categoryId: UUID) async throws -> [ActivityEntity] {
        let predicate = #Predicate<ActivityEntity> { $0.category.id == categoryId }
        return Query(filter: predicate).wrappedValue
    }
    
    static func fetchTimeThisWeek(for categoryId: UUID) async throws -> TimeInterval {
        let startOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: startOfWeek)!
        
        let predicate = #Predicate<ActivityEntity> {
            $0.category.id == categoryId &&
            $0.startDate >= startOfWeek &&
            $0.startDate <= endOfWeek
        }
        
        let activities = Query(filter: predicate).wrappedValue
        
        return activities.reduce(0) { $0 + $1.duration }
    }

}
