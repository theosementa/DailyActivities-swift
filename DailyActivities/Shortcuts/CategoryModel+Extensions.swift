//
//  CategoryModel+Extensions.swift
//  DailyActivities
//
//  Created by Theo Sementa on 21/06/2025.
//

import Foundation
import AppIntents

extension CategoryModel: AppEntity, @unchecked Sendable {
    
    public static var typeDisplayRepresentation: TypeDisplayRepresentation {
        return TypeDisplayRepresentation(name: "Categorie")
    }
    
    public static var defaultQuery = CategoryQuery()
    
    public var displayRepresentation: DisplayRepresentation {
        return DisplayRepresentation(
            title: "\(name)"
//            subtitle: "\(balance.toString(maxDigits: 2)) \(UserCurrency.symbol)"
        )
    }
    
}
