//
//  SessionAttributes.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import ActivityKit
import Foundation

struct SessionAttributes: ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
//        var elapsedTime: TimeInterval
        var startTime: Date
    }
    
    var sessionName: String
    var sessionEmoji: String
}
