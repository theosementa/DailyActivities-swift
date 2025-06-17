//
//  DailyActivitiesApp.swift
//  DailyActivities
//
//  Created by Theo Sementa on 15/06/2025.
//

import SwiftUI
import TheoKit
import NavigationKit

@main
struct DailyActivitiesApp: App {
    
    @StateObject private var router: Router<AppDestination> = .init()
    
    @State private var categoriesStore: CategoryStore = .shared
    @State private var activityStore: ActivityStore = .shared
    
    // MARK: - View
    var body: some Scene {
        WindowGroup {
            RoutedNavigationStack(router: router) {
                HomeScreen()
            }
            .environmentObject(router)
            .environment(categoriesStore)
            .environment(activityStore)
        }
    }
}
