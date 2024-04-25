import Foundation
import AVFoundation

class AudioPlayerHandGestureManager {
    static let shared = AudioPlayerHandGestureManager()
    
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    private init() {}
    
    func loadSounds() {
        loadSound(forResource: "do")
        loadSound(forResource: "re")
        loadSound(forResource: "mi")
        loadSound(forResource: "fa")
        loadSound(forResource: "sol")
        loadSound(forResource: "ra")
        loadSound(forResource: "si")
        loadSound(forResource: "highDo")
    }
    
    private func loadSound(forResource name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Cannot find the sound file for \(name)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            audioPlayers[name] = player
        } catch {
            print(" Failed to load \(name) sound file: \(error)")
        }
    }
    
    func playSound(named name: String) {
        guard let player = audioPlayers[name] else {
            print("Cannot find the audio player corresponding to \(name)")
            return
        }
        
        if !player.isPlaying {
            player.currentTime = 0
            player.play()
        }
    }
    
    func stopSound(named name: String) {
        guard let player = audioPlayers[name], player.isPlaying else { return }
        player.stop()
        player.currentTime = 0
    }
}

