//
//  CategoryDestination.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import NavigationKit
import SwiftUI

enum CategoryDestination: AppDestinationProtocol {
    case add
    case details(categoryId: UUID)
    
    var id: Self { self }
    
    func body(route: Route) -> some View {
        switch self {
        case .add:
            AddCategoryScreen()
        case .details(let categoryId):
            CategoryDetailsScreen(categoryId: categoryId)
        }
    }
}

