//
//  AddButtonView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import TheoKit

struct AddButtonView: View {
    
    // MARK: Dependencies
    var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - View
    var body: some View {
        Button {
            
        } label: {
            IconSVGView(icon: .iconDiamondPlus, value: .large)
                .foregroundStyle(Color.white)
                .padding(TKDesignSystem.Padding.medium)
                .roundedRectangleBorder(
                    Color.blue,
                    radius: TKDesignSystem.Radius.medium
                )
        }
    }
}

// MARK: - Preview
#Preview {
    AddButtonView { }
}
