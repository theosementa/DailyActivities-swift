//
//  CategoryModel.swift
//  DailyActivities
//
//  Created by Theo Sementa on 21/06/2025.
//

import Foundation
import SwiftUICore

struct CategoryModel {
    let localId: UUID
    var name: String
    var emoji: String
    var color: Color
    
    var elapsedTimeThisWeek: TimeInterval = 0
    
    init(localId: UUID, name: String, emoji: String, color: Color) {
        self.localId = localId
        self.name = name
        self.emoji = emoji
        self.color = color
    }
}

extension CategoryModel: Identifiable {
    
    var id: UUID {
        return localId
    }
    
}

// MARK: - Mocks
extension CategoryModel {
    
    static let preview = CategoryModel(
        localId: UUID(),
        name: "Gaming",
        emoji: "🎮",
        color: Color(hex: "#FF5733")
    )
    
}
