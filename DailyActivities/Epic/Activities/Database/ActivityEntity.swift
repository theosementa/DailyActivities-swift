//
//  ActivityEntity.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import SwiftData

@Model
final class ActivityEntity: Identifiable {
 
    @Attribute(.unique)
    var id: UUID = UUID()
    
    var startDate: Date = Date()
    
    var endDate: Date? = nil
    
    var notes: String = ""
    
    var categoryId: UUID
    
    init(
        startDate: Date = .now,
        endDate: Date? = nil,
        notes: String = "",
        categoryId: UUID
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        self.categoryId = categoryId
    }
    
}

@MainActor
extension ActivityEntity {
    
    var category: CategoryEntity? {
        return CategoryStore.shared.findOneById(self.categoryId)
    }
    
    var duration: TimeInterval {
        let endDate = self.endDate ?? Date()
        return endDate.timeIntervalSince(self.startDate)
    }
    
}
    
// MARK: - Mocks
extension ActivityEntity {
    
    static let preview: ActivityEntity = .init(
        startDate: Date(timeIntervalSinceNow: -3600),
        endDate: Date(),
        notes: "Test activity",
        categoryId: CategoryEntity.preview.id
    )
    
}
