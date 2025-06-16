//
//  CategoriesStore.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation

@Observable @MainActor
final class CategoriesStore {
    static let shared: CategoriesStore = .init()
    let repository = CategoryRepository()
    
    var categories: [CategoryEntity] = []
}

@MainActor
extension CategoriesStore {
 
    func fetchAll(fromNetwork: Bool = false) async {
        do {
            self.categories = try repository.fetchAll()
            if fromNetwork {
                
            }
        } catch {
            
        }
    }
    
    func create(_ category: CategoryEntity) async throws {
        do {
            try repository.insert(category)
        } catch {
            
        }
    }
    
    func delete(_ category: CategoryEntity) async throws {
        do {
            try repository.delete(category)
        } catch {
            
        }   
    }

}

