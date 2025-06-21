//
//  CategoryQuery.swift
//  DailyActivities
//
//  Created by Theo Sementa on 21/06/2025.
//

import Foundation
import AppIntents

struct CategoryQuery: EntityQuery {
    
    func entities(for identifiers: [CategoryModel.ID]) async throws -> [CategoryModel] {
        let categories = try await CategoryRepository().fetchAll().map { $0.toModel() }
        let categoriesFiltered = categories.filter { identifiers.contains($0.id) }
        return categoriesFiltered
    }
    
    func suggestedEntities() async throws -> [CategoryModel] {
        let categories = try await CategoryRepository().fetchAll().map { $0.toModel() }
        return categories.sorted { $0.name < $1.name }
    }
    
}
