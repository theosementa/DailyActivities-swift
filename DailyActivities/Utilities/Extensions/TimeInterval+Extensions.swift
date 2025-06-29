//
//  TimeInterval+Extensions.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation

extension TimeInterval {
    
    var asHoursMinutes: String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%dh%02d", hours, minutes)
        } else if minutes > 0 {
            return String(format: "%dmin%ds", minutes, seconds)
        } else {
            return "\(seconds)s"
        }
    }
    
}
