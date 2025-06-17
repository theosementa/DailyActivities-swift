//
//  AddCategoryScreen+ViewModel.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import SwiftUI

extension AddCategoryScreen {
    
    @Observable
    final class ViewModel {
        var emoji: String = "🎮"
        var name : String = ""
        var color: Color? = nil
        
        var fieldHeight: CGFloat = 0
    }
    
}

extension AddCategoryScreen.ViewModel {
    
    var categoryEntity: CategoryEntity {
        CategoryEntity(
            name: name,
            emoji: emoji,
            colorHex: color?.toHex() ?? "#FFFFFF"
        )
    }
    
}
