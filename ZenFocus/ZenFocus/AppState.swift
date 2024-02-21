//
//  AppState.swift
//  ZenFocus
//
//  Created by Kwaw Annan on 2/20/24.
//

import SwiftUI
import NotificationCenter

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var isLocked = false
    @Published var pomodoroTime = 25 * 60 // 25 minutes
    
    private var timer: Timer?
    
    init() {
        setupNotifications()
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(screenDidLock), name: UIApplication.protectedDataWillBecomeUnavailableNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(screenDidUnlock), name: UIApplication.protectedDataDidBecomeAvailableNotification, object: nil)
    }
    
    @objc func screenDidLock() {
        isLocked = true
        stopPomodoro()
    }
    
    @objc func screenDidUnlock() {
        isLocked = false
        // Optionally restart the Pomodoro or handle as needed
    }
    
    func startPomodoro() {
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.pomodoroTime > 0 {
                self.pomodoroTime -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    func stopPomodoro() {
        timer?.invalidate()
    }
}
