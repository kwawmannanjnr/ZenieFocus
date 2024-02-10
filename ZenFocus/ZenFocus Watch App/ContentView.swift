//
//  ContentView.swift
//  ZenFocus Watch App
//
//  Created by Kwaw Annan on 1/29/24.
//

import SwiftUI
import AVFoundation

//MulitColor Gradient
let hueColors = stride(from: 0, to: 1,by: 0.01).map {
    Color(hue: $0, saturation: 1, brightness: 1)}
    
private let gradient = LinearGradient(gradient:Gradient(colors: hueColors),startPoint: .leading, endPoint: .trailing)
struct ContentView: View {
        var body: some View {
            ZStack {
                Color.black.opacity(1).edgesIgnoringSafeArea(.all)
                CircularSlider()
                    .offset(x: -0.5, y: -11)
                    .rotationEffect (.degrees (180))
            }
        }
    }
struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
struct CircularSlider: View {
    @State var progress: CGFloat = 0
    @State var angle: Double = 0
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .stroke (Color.gray.opacity(0.2),style: StrokeStyle(lineWidth: 10,lineCap: .round,lineJoin: .round))
                Circle()
                    .trim(from: 0,to: progress)
                    .stroke(gradient , style: StrokeStyle(lineWidth: 10,lineCap: .round))
                    .frame(width: 140,height: 140)
                    .rotationEffect(.init(degrees: -90))
                
            //Drag Circle
                
                Image("fake")
                    .resizable()
                    .frame(width: 40,height: 40)
                    .offset(x:140 / 2)
                    .rotationEffect(.init(degrees: angle))
                    //Add Gestures
                    .gesture(DragGesture().onChanged(onDrag(value:)))
                    .rotationEffect(.init(degrees: -90))
                VStack{
                    //Inside Slider
                    Text("Kwaw")
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .fontWeight(.regular)
                        .rotationEffect(.degrees(180))
                    HStack{
                        Text("%")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .fontWeight(.regular)
                            
                        Text(String(format: "%.0f",progress * 100))
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.regular)
                            .rotationEffect(.degrees(180))
                    }
                }
                
            }
        }
    }
    func onDrag(value: DragGesture.Value){
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radians = atan2(vector.dy - 27.5, vector.dx - 27.5 )
        var angle = radians * 180 / .pi
        if angle < 0{angle = 360 + angle}
        withAnimation(Animation.linear(duration: 0.15)){
            //progress
            
            let progress = angle / 360
            self.progress = progress
            self.angle = Double(angle)
        }
        
    }
}
//struct ContentView: View {
//    @StateObject var beatGenerator = BinauralBeatGenerator()
//    
//    var body: some View {
//        ZStack {
//            GeometryReader { geometry in
//                // Determine the minimum dimension to ensure the circle fits on the screen
//                let diameter = min(geometry.size.width, geometry.size.height) * 1 // 80% of the smallest screen dimension
//               
//                ZStack{
//                    Text("Pomodoro")
//                        .font(.subheadline)
//                        .padding()
//                    Text("30:00").font(Font.system(size: 40))
//                        .padding(.top)
//                    //                    .font(.subhedline)
//                    Text("Begin Focus")
//                        .font(.subheadline)
//                        .padding()
//                    
//                    Button(action: {
//                        print("Button was tapped")
//                    }) {
//                        Text("Tap Me")
//                            .foregroundColor(.white)
//                            .bold()
//                            .padding(.bottom)
//                        
//                    }
//                }
//            }
//               }
//        VStack {
//            Text("Binaural Beats Player")
//                .font(.largeTitle)
//                .padding()
//            
//            Button(action: {
//                if beatGenerator.isPlaying {
//                    beatGenerator.stop()
//                } else {
//                    beatGenerator.startEngine()
//                    beatGenerator.play(frequency: 440, binauralDifference: 40) // Example: A4 tone with 40Hz binaural beat
//                }
//            }) {
//                Text(beatGenerator.isPlaying ? "Stop" : "Play 440Hz + 40Hz Beat")
//                    .font(.title)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
    

#Preview {
    ContentView()
}
