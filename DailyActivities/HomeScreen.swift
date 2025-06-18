//
//  HomeScreen.swift
//  DailyActivities
//
//  Created by Theo Sementa on 15/06/2025.
//

import SwiftUI
import TheoKit
import NavigationKit

struct HomeScreen: View {
    
    // MARK: Environments
    @Environment(CategoryStore.self) private var categoryStore
    @EnvironmentObject private var router: Router<AppDestination>

    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(
                title: "Hello, Théo !".localized,
                withDismissButton: false,
                actionButton: .init(
                    icon: .iconGear,
                    color: Color.label,
                    action: { }
                )
            )
            
            ScrollView {
                VStack(spacing: TKDesignSystem.Spacing.medium) {
                    ForEach(categoryStore.categories) { category in
                        NavigationButton(
                            route: .push,
                            destination: AppDestination.category(.details(categoryId: category.id))
                        ) {
                            CategoryRowView(category: category)
                        }
                    }
                }
                .padding(TKDesignSystem.Padding.large)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(TKDesignSystem.Colors.Background.Theme.bg50)
        .overlay(alignment: .bottomTrailing) {
            AddButtonView {
                router.push(.category(.add))
            }
            .padding(TKDesignSystem.Padding.large)
        }
        .onViewDidLoad {
            await categoryStore.fetchAll()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeScreen()
}
