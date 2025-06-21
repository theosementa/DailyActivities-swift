//
//  GenericRepository.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//


import Foundation
import SwiftData

@MainActor
class GenericRepository<T: PersistentModel> {
    let container: ModelContainer
    let context: ModelContext

    init() {
        let manager: SwiftDataContextManager = .shared
        
        self.container = manager.container
        self.context = manager.context
    }
}

extension GenericRepository {
    func insert(_ entity: T) throws {
        container.mainContext.insert(entity)
        try container.mainContext.save()
    }

    func delete(_ entity: T) throws {
        container.mainContext.delete(entity)
        try container.mainContext.save()
    }
    
    func fetchAll() throws -> [T] {        
        let fetchDescriptor = FetchDescriptor<T>(sortBy: [])
        let items = try container.mainContext.fetch(fetchDescriptor)
        return items
    }
    
    func fetchOneById(_ id: PersistentIdentifier) throws -> T {
        let predicate = #Predicate<T> { $0.persistentModelID == id }
        
        var fetchDescriptor = FetchDescriptor<T>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        
        let results = try container.mainContext.fetch(fetchDescriptor)
        if let first = results.first {
            return first
        } else {
            throw NSError(domain: "Error fetch one by id", code: 10)
        }
    }
}
