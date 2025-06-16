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
    
    init(
        startDate: Date = .now,
        endDate: Date? = nil,
        notes: String = ""
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
    }
    
}

extension ActivityEntity {
    
    var duration: TimeInterval {
        let endDate = self.endDate ?? Date()
        return endDate.timeIntervalSince(self.startDate)
    }
}
    
