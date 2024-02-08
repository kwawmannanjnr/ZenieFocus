//
//  ContentView.swift
//  ZenFocus
//
//  Created by Kwaw Annan on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var beatGenerator = BinauralBeatGenerator()
    
    var body: some View {
        var baseFrequency = 100
        BinauralBeatsView()

        VStack {
            Text("Binaural Beats Player")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                if beatGenerator.isPlaying {
                    beatGenerator.stop()
                } else {
                    beatGenerator.startEngine()
                    beatGenerator.play(frequency: Double(baseFrequency), binauralDifference: 40) // Example: A4 tone with 40Hz binaural beat
                }
            }) {
                Text(beatGenerator.isPlaying ? "Stop" : "Play \(baseFrequency)Hz + 40Hz Beat")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)

            }
        }
    }
}
struct BinauralBeatsView: View {
    // Parameters for animation and wave customization
    @State private var animate = false
    let waveAmplitude: CGFloat = 10 // Adjust for wave height
    let waveFrequency: CGFloat = 20 // Adjust for number of waves
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8) // Background color
            
            // Left wave
            WaveView(animate: $animate, amplitude: waveAmplitude, frequency: waveFrequency)
                .offset(x: animate ? -100 : -UIScreen.main.bounds.width / 2)
            
            // Right wave (mirrored)
            WaveView(animate: $animate, amplitude: -waveAmplitude, frequency: waveFrequency)
                .scaleEffect(x: -1, y: 1, anchor: .center) // Mirror the wave horizontally
                .offset(x: animate ? 100 : UIScreen.main.bounds.width / 2)
            
            // Central glow effect
            Circle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 200, height: 200)
                .blur(radius: 50)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                animate = true
            }
        }
    }
}

struct WaveView: View {
    @Binding var animate: Bool
    let amplitude: CGFloat // Wave height
    let frequency: CGFloat // Number of waves
    
    var body: some View {
        Canvas { context, size in
            context.draw(Text("Binaural Beats"), at: CGPoint(x: size.width / 2, y: 20)) // Optional: Title
            
            // Draw the wave
            let path = Path { path in
                for x in stride(from: 0, to: size.width, by: 1) {
                    let relativeX = x / size.width
                    let normWave = sin(relativeX * frequency + (animate ? .pi / 2 : 0)) // Wave formula
                    let y = normWave * amplitude + size.height / 2 // Adjust wave position
                    
                    if x == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            
            context.stroke(path, with: .color(.white), lineWidth: 2)
        }
        .frame(height: 200) // Adjust for wave view size
    }
}

struct BinauralBeatsView_Previews: PreviewProvider {
    static var previews: some View {
        BinauralBeatsView()
    }
}
#Preview {
    ContentView()
}
