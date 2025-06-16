//
//  IconSVGView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI

enum IconSVGValue: CGFloat {
    /// Value `10`
    case extraSmall = 10
    /// Value `14`
    case small = 14
    /// Value `16`
    case standard = 16
    /// Value `20`
    case medium = 20
    /// Value `24`
    case large = 24
}

struct IconSVGView: View {
    
    // MARK: Dependencies
    var icon: ImageResource
    var value: IconSVGValue
    
    // MARK: - View
    var body: some View {
        Image(icon)
            .resizable()
            .renderingMode(.template)
            .frame(width: value.rawValue, height: value.rawValue)
    }
}
