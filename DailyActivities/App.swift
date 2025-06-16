//
//  DailyActivitiesApp.swift
//  DailyActivities
//
//  Created by Theo Sementa on 15/06/2025.
//

import SwiftUI
import TheoKit

@main
struct DailyActivitiesApp: App {
    
    @State private var categoriesStore: CategoriesStore = .init()
    
    // MARK: - View
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(categoriesStore)
        }
    }
}
