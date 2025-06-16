//
//  EmojiPickerView.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import SwiftUI
import MCEmojiPicker
import TheoKit

struct EmojiPickerView: View {
    
    // MARK: Dependencies
    @Binding var emoji: String
    var width: CGFloat
    
    // MARK: States
    @State private var showEmojiPicker: Bool = false
    
    // MARK: - View
    var body: some View {
        Button { showEmojiPicker.toggle() } label: {
            Text(emoji)
                .font(.system(size: 24))
                .frame(width: width, height: width)
                .roundedRectangleBorder(
                    TKDesignSystem.Colors.Background.Theme.bg100,
                    radius: TKDesignSystem.Radius.medium
                )
        }
        .emojiPicker(
            isPresented: $showEmojiPicker,
            selectedEmoji: $emoji
        )
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var emoji: String = "😀"
    EmojiPickerView(emoji: $emoji, width: 50)
}
