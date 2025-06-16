//
//  ContentView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 15/06/2025.
//

import SwiftUI
import TheoKit

struct ContentView: View {

    // MARK: - View
    var body: some View {
        Text("Content View")
            .fontWithLineHeight(Fonts.Body.large)
        
        Text("Content View")
            .font(.custom("Satoshi-Medium", size: 16))
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .applyDesignSystem()
}
