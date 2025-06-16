//
//  CategoryEntity.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import SwiftData

@Model
final class CategoryEntity: Identifiable {
    
    @Attribute(.unique)
    var id: UUID = UUID()
    
    var name: String
    
    var emoji: String
    
    var colorHex: String
    
    init(name: String, emoji: String, colorHex: String) {
        self.name = name
        self.emoji = emoji
        self.colorHex = colorHex
    }
    
}
    
