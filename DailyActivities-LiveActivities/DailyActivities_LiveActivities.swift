////
////  DailyActivities_LiveActivities.swift
////  DailyActivities-LiveActivities
////
////  Created by Theo Sementa on 16/06/2025.
////
//
//import WidgetKit
//import SwiftUI
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), emoji: "😀")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), emoji: "😀")
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, emoji: "😀")
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//
////    func relevances() async -> WidgetRelevances<Void> {
////        // Generate a list containing the contexts this widget is relevant in.
////    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let emoji: String
//}
//
//struct DailyActivities_LiveActivitiesEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        VStack {
//            Text("Time:")
//            Text(entry.date, style: .time)
//
//            Text("Emoji:")
//            Text(entry.emoji)
//        }
//    }
//}
//
//struct DailyActivities_LiveActivities: Widget {
//    let kind: String = "DailyActivities_LiveActivities"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            if #available(iOS 17.0, *) {
//                DailyActivities_LiveActivitiesEntryView(entry: entry)
//                    .containerBackground(.fill.tertiary, for: .widget)
//            } else {
//                DailyActivities_LiveActivitiesEntryView(entry: entry)
//                    .padding()
//                    .background()
//            }
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//#Preview(as: .systemSmall) {
//    DailyActivities_LiveActivities()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}







import SwiftUI
import WidgetKit
import ActivityKit

struct PrintingTimeActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SessionAttributes.self) { context in
            LiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.sessionEmoji)
                        .font(.title)
                        .padding()
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text(context.attributes.sessionName)
                        .font(.title)
                        .padding()
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.startTime, style: .timer)
//                    Text(timeString(from: context.state.elapsedTime))
                        .font(.title)
//                        .fixedSize(horizontal: true, vertical: true)
                        .padding()
                }
            } compactLeading: {
                Text(context.attributes.sessionEmoji)
            } compactTrailing: {
                Text(context.state.startTime, style: .timer)
//                Text(timeString(from: context.state.elapsedTime))
//                    .fixedSize(horizontal: true, vertical: true)
            } minimal: {
                Text(context.state.startTime, style: .timer)
//                Text(timeString(from: context.state.elapsedTime))
//                    .fixedSize(horizontal: true, vertical: true)
            }
        }
    }
    
    private func timeString(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
                
//                Text(timeString(from: context.state.elapsedTime))
                Text(context.state.startTime, style: .timer)
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func timeString(from seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - Preview
#Preview(as: .content, using: SessionAttributes.init(sessionName: "Preview Session", sessionEmoji: "🎮")) {
    PrintingTimeActivity()
} contentStates: {
//    SessionAttributes.ContentState(elapsedTime: 10)
    SessionAttributes.ContentState(startTime: .now)
}
