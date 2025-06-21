//
//  CategoryQuery.swift
//  DailyActivities
//
//  Created by Theo Sementa on 21/06/2025.
//

import Foundation
import AppIntents


struct CategoryQuery: EntityQuery {
    
    func entities(for identifiers: [CategoryEntity.ID]) async throws -> [CategoryEntity] {
        let categories = try await CategoryRepository().fetchAll()
        let categoriesFiltered = categories.filter { identifiers.contains($0.id) }
        return categoriesFiltered
    }
    
    func suggestedEntities() async throws -> [CategoryEntity] {
        let categories = try await CategoryRepository().fetchAll()
        return categories.sorted { $0.name < $1.name }
    }
    
}
