//
//  HomeScreen.swift
//  DailyActivities
//
//  Created by Theo Sementa on 15/06/2025.
//

import SwiftUI
import TheoKit

struct HomeScreen: View {
    
    // MARK: Environments
    @Environment(CategoriesStore.self) private var categoriesStore

    // MARK: - View
    var body: some View {
        ScrollView {
            ForEach(categoriesStore.categories) { category in
                CategoryRowView(category: category)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottomTrailing) {
            AddButtonView {
                
            }
        }
        .onViewDidLoad {
            await categoriesStore.fetchAll()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeScreen()
}
