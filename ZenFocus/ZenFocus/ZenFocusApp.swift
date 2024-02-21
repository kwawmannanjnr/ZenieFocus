//
//  ZenFocusApp.swift
//  ZenFocus
//
//  Created by Kwaw Annan on 1/29/24.
//

import SwiftUI

@main
struct ZenFocusApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .background:
                        print("App moved to background")
                        // Stop or pause Pomodoro timer
                    case .active:
                        print("App is in foreground")
                        // Conditionally resume or start new Pomodoro timer
                    case .inactive:
                        break
                    @unknown default:
                        print("Unexpected new scene phase.")
                    }
                }
        }
    }
}
