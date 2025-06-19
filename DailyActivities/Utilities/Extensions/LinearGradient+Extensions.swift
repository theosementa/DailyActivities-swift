//
//  LinearGradient.swift
//  DailyActivities
//
//  Created by Theo Sementa on 19/06/2025.
//

import Foundation
import SwiftUICore
import TheoKit

extension LinearGradient {
    
    init(autoGradientForColor colorHex: String) {
        self.init(
            colors: [
                Color(hex: colorHex),
                Color(hex: colorHex).adjustLightness(percent: -15)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
}
