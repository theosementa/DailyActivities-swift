//
//  AppDestination.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import NavigationKit
import SwiftUI

enum AppDestination: AppDestinationProtocol {
    case category(CategoryDestination)
    
    var id: Self { self }
    
    func body(route: Route) -> some View {
        switch self {
        case .category(let categoryDestination):
            categoryDestination.body(route: route)
        }
    }
}
