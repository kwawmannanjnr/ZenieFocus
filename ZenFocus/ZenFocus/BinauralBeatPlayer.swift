//
//  File.swift
//  ZenFocus
//
//  Created by Kwaw Annan on 1/29/24.
//

import Foundation
import AVFoundation

class BinauralBeatGenerator: ObservableObject {
    private var audioEngine: AVAudioEngine
    private var toneNodeLeft: AVAudioPlayerNode
    private var toneNodeRight: AVAudioPlayerNode

    @Published var isPlaying = false
    
    init() {
        audioEngine = AVAudioEngine()
        toneNodeLeft = AVAudioPlayerNode()
        toneNodeRight = AVAudioPlayerNode()
        
        audioEngine.attach(toneNodeLeft)
        audioEngine.attach(toneNodeRight)
        
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)
        audioEngine.connect(toneNodeLeft, to: audioEngine.mainMixerNode, format: audioFormat)
        audioEngine.connect(toneNodeRight, to: audioEngine.mainMixerNode, format: audioFormat)
    }
    
    func startEngine() {
        do {
            try audioEngine.start()
        } catch {
            print("AudioEngine didn't start")
        }
    }
    
    func play(frequency: Double, binauralDifference: Double) {
        let leftFrequency = frequency
        let rightFrequency = frequency + binauralDifference
        
        let leftTone = generateTone(frequency: leftFrequency)
        let rightTone = generateTone(frequency: rightFrequency)
//        
        toneNodeLeft.scheduleBuffer(leftTone, at: nil, options: .loops, completionHandler: nil)
        toneNodeRight.scheduleBuffer(rightTone, at: nil, options: .loops, completionHandler: nil)
        
        toneNodeLeft.play()
        toneNodeRight.play()
        
        isPlaying = true
    }
    
    func stop() {
        toneNodeLeft.stop()
        toneNodeRight.stop()
        
        isPlaying = false
    }
    
    private func generateTone(frequency: Double) -> AVAudioPCMBuffer {
        let sampleRate = 44100
        let duration = 1.0
        let frameCount = Double(sampleRate) * duration
        let audioFormat = AVAudioFormat(standardFormatWithSampleRate: Double(sampleRate), channels: 1)!
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: AVAudioFrameCount(frameCount))!
        
        let theta_increment = 2.0 * Double.pi * frequency / Double(sampleRate)
        
        for frame in 0..<Int(frameCount) {
            let theta = theta_increment * Double(frame)
            let sample = sin(theta)
            buffer.floatChannelData!.pointee[frame] = Float(sample)
        }
        
        buffer.frameLength = AVAudioFrameCount(frameCount)
        
        return buffer
    }
}
