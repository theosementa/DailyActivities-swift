//
//  TKDesignSystem+Extensions.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import TheoKit
import SwiftUICore

extension TKDesignSystem {
    
    static func setupFonts() {
        TKDesignSystem.fontBold = "Satoshi-Bold"
        TKDesignSystem.fontMedium = "Satoshi-Medium"
        TKDesignSystem.fontRegular = "Satoshi-Regular"
    }
    
}

extension View {
    
    func applyDesignSystem() -> some View {
        self
            .onAppear {
                TKDesignSystem.setupFonts()
            }
    }
    
}
