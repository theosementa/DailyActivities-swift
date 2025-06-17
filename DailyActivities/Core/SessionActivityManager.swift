//
//  SessionActivityManager.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import ActivityKit

@Observable
class SessionActivityManager {
    static let shared = SessionActivityManager()
    
    var isSessionRunning: Bool = false
    var sessionStartAt: Date? = nil
    
    var sessionActivity: Activity<SessionAttributes>? = nil
}

extension SessionActivityManager {
    
    func startLiveActivity(
        sessionName: String,
        sessionEmoji: String,
        sessionColorHex: String
    ) {
        let attributes = SessionAttributes(
            sessionName: sessionName,
            sessionEmoji: sessionEmoji,
            sessionColorHex: sessionColorHex
        )
        
        let initialState = SessionAttributes.ContentState(startTime: .now)
        
        do {
            sessionActivity = try Activity.request(
                attributes: attributes,
                content: ActivityContent(state: initialState, staleDate: nil)
            )
            sessionStartAt = Date()
            isSessionRunning = true
        } catch {
            print("Error starting live activity: \(error)")
        }
    }
    
    func cancelLiveActivity() {
        isSessionRunning = false
        sessionStartAt = nil
        endLiveActivity()
        sessionActivity = nil
    }
    
    func endLiveActivity(success: Bool = false) {
        Task {
            await sessionActivity?.end(nil, dismissalPolicy: .immediate)
            isSessionRunning = false
            sessionStartAt = nil
        }
    }
    
}
