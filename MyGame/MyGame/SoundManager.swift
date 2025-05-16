import Foundation
import AVFAudio

var audioPlayer: AVAudioPlayer? // مشترك

func playSound(for isCorrect: Bool) {
    let soundName = isCorrect ? "success" : "failure"
    if let url = Bundle.main.url(forResource: soundName, withExtension: "wav") {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            print("✅ تشغيل: \(soundName)")
        } catch {
            print("❌ خطأ تشغيل الصوت: \(error.localizedDescription)")
        }
    } else {
        print("❌ الملف مفقود: \(soundName).wav")
    }
}
