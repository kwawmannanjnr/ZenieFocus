//
//  PomodoroView.swift
//  ZenFocus
//
//  Created by Kwaw Annan on 2/20/24.
//

import Foundation
import SwiftUI

struct PomodoroView: View {
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        VStack {
            Text("Pomodoro Timer")
                .font(.largeTitle)
           
            Text("\(appState.pomodoroTime) seconds")
                .font(.title)
            
            Button("Start Pomodoro") {
                appState.startPomodoro()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            appState.stopPomodoro()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            // Optionally restart or handle as needed
        }
    }
}
