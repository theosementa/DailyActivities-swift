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
    
    @Attribute(.ephemeral)
    var elapsedTimeThisWeek: TimeInterval = 0
        
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
    
    func toModel() -> CategoryModel {
        return .init(
            localId: self.id,
            name: self.name,
            emoji: self.emoji,
            color: Color(hex: self.colorHex)
        )
    }
        
}
