//
//  SessionActivityViewModel.swift
//  DailyActivities
//
//  Created by Theo Sementa on 16/06/2025.
//

import Foundation
import ActivityKit

@Observable
class SessionActivityViewModel {

    var sessionName: String = ""
    var sessionEmoji: String = ""
    
    var sessionActivity: Activity<SessionAttributes>? = nil
    var elapsedTime: TimeInterval = 0
    
}

extension SessionActivityViewModel {
    
    func startLiveActivity() {
        let attributes = SessionAttributes(
            sessionName: sessionName,
            sessionEmoji: sessionEmoji
        )
        
//        let initialState = SessionAttributes.ContentState(elapsedTime: 0)
        let initialState = SessionAttributes.ContentState(startTime: .now)
        
        do {
            sessionActivity = try Activity.request(
                attributes: attributes,
                content: ActivityContent(state: initialState, staleDate: nil)
            )
        } catch {
            print("Error starting live activity: \(error)")
        }
    }
    
//    func updateLiveActivity() {
//        let updatedState = SessionAttributes.ContentState(elapsedTime: elapsedTime)
//        
//        Task {
//            await sessionActivity?.update(using: updatedState)
//        }
//    }
    
    func endLiveActivity(success: Bool = false) {
//        let finalState = SessionAttributes.ContentState(
//            elapsedTime: elapsedTime
//        )
        
        Task {
            //await printActivity?.end(using: finalState, dismissalPolicy: .default)
//            await sessionActivity?.end(
//                ActivityContent(state: nil, staleDate: nil),
//                dismissalPolicy: .default
//            )
            await sessionActivity?.end(
                nil,
                dismissalPolicy: .default
            )
        }
    }
    
}

