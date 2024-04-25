import AVFoundation

class AudioPlayerPlayMelodyManager {
    static let shared = AudioPlayerPlayMelodyManager()
    var audioPlayer: AVAudioPlayer?
    var onCompletion: (() -> Void)?
    
    
    func playSound(sound: String, completion: (() -> Void)? = nil) {
        
        self.onCompletion = completion
        
        if let url = Bundle.main.url(forResource: sound, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("ERROR: Could not find and play the \(sound) sound file!")
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onCompletion?()
    }
    
}

