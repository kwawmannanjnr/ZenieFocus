//
//  ContentView.swift
//  ZenFocus Pomodoro
//
//  Created by Kwaw Annan on 1/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: CGFloat = 1.0
    @State private var totalTime: CGFloat = 1500 // Represents 25 minutes in seconds
    @State private var remainingTime: CGFloat = 100 // 25 minutes
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.red)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear(duration: 0.2))
                
                Text(timeString(time: remainingTime))
                    .font(.largeTitle)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.progress = self.remainingTime / self.totalTime
            }
        }
    }

    func timeString(time: CGFloat) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
