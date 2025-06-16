//
//  CategoryEntity.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import SwiftData
import SwiftUICore

@Model
final class CategoryEntity: Identifiable {
    
    @Attribute(.unique)
    var id: UUID = UUID()
    
    var name: String
    
    var emoji: String
    
    var colorHex: String
    
    @Relationship(deleteRule: .cascade, inverse: \ActivityEntity.category)
    var activities: [ActivityEntity] = []
    
    init(name: String, emoji: String, colorHex: String) {
        self.name = name
        self.emoji = emoji
        self.colorHex = colorHex
    }
    
}

extension CategoryEntity {
    
    var color: Color {
        return Color(hex: self.colorHex)
    }
    
    var elapsedThisWeek: TimeInterval {
        let startOfWeek = Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.yearForWeekOfYear, .weekOfYear],
                from: Date()
            )
        )!
        return activities.reduce(0) { total, activity in
            if activity.startDate >= startOfWeek {
                return total + activity.duration
            }
            return total
        }
    }
    
}

// MARK: - Mocks
extension CategoryEntity {
    
    static let preview = CategoryEntity(
        name: "Gaming",
        emoji: "🎮",
        colorHex: "#FF5733"
    )
    
}
