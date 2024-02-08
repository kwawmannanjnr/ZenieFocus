//
//  ContentView.swift
//  ZenFocus Watch App
//
//  Created by Kwaw Annan on 1/29/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var beatGenerator = BinauralBeatGenerator()
    
    var body: some View {
        VStack {
            Text("Binaural Beats Player")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                if beatGenerator.isPlaying {
                    beatGenerator.stop()
                } else {
                    beatGenerator.startEngine()
                    beatGenerator.play(frequency: 440, binauralDifference: 40) // Example: A4 tone with 40Hz binaural beat
                }
            }) {
                Text(beatGenerator.isPlaying ? "Stop" : "Play 440Hz + 40Hz Beat")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}


#Preview {
    ContentView()
}
