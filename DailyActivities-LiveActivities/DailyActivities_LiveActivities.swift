//
//  DailyActivities_LiveActivities.swift
//  DailyActivities-LiveActivities
//
//  Created by Theo Sementa on 16/06/2025.
//
// https://developer.apple.com/documentation/widgetkit/displaying-dynamic-dates

import SwiftUI
import WidgetKit
import ActivityKit
import TheoKit

struct PrintingTimeActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionAttributes.self) { context in
            LiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {                
                DynamicIslandExpandedRegion(.center, priority: 1) {
                    HStack(spacing: 12) {
                        Text(context.attributes.sessionEmoji)
                            .padding(8)
                            .background {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(Color(hex: context.attributes.sessionColorHex))
                            }
                        Text(context.attributes.sessionName)
                        Text(context.state.startTime, style: .relative)
                            .monospacedDigit()
                            .multilineTextAlignment(.trailing)
                    }
                    .font(.title2)
                    .padding()
                    
                }
            } compactLeading: {
                HStack(spacing: 4) {
                    Text(context.attributes.sessionEmoji)
                    Text(context.attributes.sessionEmoji)
                }
                .font(.system(size: 12))
                .padding(.horizontal, 4)
                .frame(maxHeight: .infinity)
                .background(Color(hex: context.attributes.sessionColorHex), in: .capsule)
            } compactTrailing: {
                Text(context.state.startTime, style: .relative)
                    .monospacedDigit()
                    .multilineTextAlignment(.trailing)
            } minimal: {
                Text(context.attributes.sessionEmoji)
            }
        }
    }
    
}

struct LiveActivityView: View {
    
    let context: ActivityViewContext<SessionAttributes>
    
    var body: some View {
        HStack(spacing: 12) {
            Text(context.attributes.sessionEmoji)
                .font(.system(size: 32))
            
            VStack(alignment: .leading) {
                Text(context.attributes.sessionName)
                    .font(.headline)
                
                Text(context.state.startTime, style: .relative)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .activityBackgroundTint(Color(hex: context.attributes.sessionColorHex))
    }
}

// MARK: - Preview
#Preview(
    as: .content,
    using: SessionAttributes
        .init(
            sessionName: "Preview Session",
            sessionEmoji: "🎮",
            sessionColorHex: "#FF5733"
        )
) {
    PrintingTimeActivity()
} contentStates: {
    SessionAttributes.ContentState(startTime: .now)
}
