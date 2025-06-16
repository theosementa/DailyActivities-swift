//
//  SwiftDataContextManager.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//


import Foundation
import SwiftData

@MainActor
final class SwiftDataContextManager: ObservableObject {
    static let shared = SwiftDataContextManager()
    
    let container: ModelContainer
    var context: ModelContext
    
    private init() {
        do {
            container = try ModelContainer(for: CategoryEntity.self, ActivityEntity.self)
            context = container.mainContext
        } catch {
            fatalError("Échec de l'initialisation du ModelContainer: \(error.localizedDescription)")
        }
    }
}
