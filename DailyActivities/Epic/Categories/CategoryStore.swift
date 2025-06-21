//
//  CategoryStore.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation

@Observable @MainActor
final class CategoryStore {
    static let shared: CategoryStore = .init()
    let repository = CategoryRepository()
    
    private init() { }
    
    private(set) var categories: [CategoryModel] = []
}

@MainActor
extension CategoryStore {
 
    func fetchAll(fromNetwork: Bool = false) async {
        do {
            self.categories = try repository.fetchAll().map { $0.toModel() }
            if fromNetwork {
                
            }
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func create(_ category: CategoryEntity) async {
        do {
            try repository.insert(category)
            self.categories.append(category.toModel())
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func updateLocaly(_ category: CategoryModel) {
        if let index = self.categories.firstIndex(where: { $0.id == category.id }) {
            self.categories[index] = category
        }
    }
    
    func delete(_ category: CategoryEntity) async {
        do {
            try repository.delete(category)
            self.categories.removeAll { $0.id == category.id }
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }   
    }

}

extension CategoryStore {
    
    func findOneById(_ id: UUID) -> CategoryModel? {
        return self.categories.first { $0.id == id }
    }
    
    
}

