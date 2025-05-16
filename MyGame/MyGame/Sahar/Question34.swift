import SwiftUI
import AVFoundation

struct Level31View: View {
    @State private var skipCount = 0
    @State private var selectedCircles: Set<Int> = []
    @State private var audioPlayer: AVAudioPlayer?
    @State private var pageNumber: String = "٣٤"
    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            VStack(spacing: -88) { // تقليل المسافة الرأسية
                // Title
                Text("كم فتحه بالفروه")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top,-70)
                ZStack {
                    Image("fro")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .padding(.top, 50) // تقليل padding

                    // Numbered circles (8 فتحات)
                    ForEach(1..<9) { number in
                        numberedCircle(number: number, x: CGFloat(50 * (number % 3 - 1)), y: CGFloat(50 * (number / 3 - 1)))
                    }
                }
                .padding()

                // Buttons for adding or subtracting circles
                HStack(spacing: 10) { // تقليل المسافة بين الأزرار
                    Button(action: {
                        if selectedCircles.count > 0 {
                            selectedCircles.remove(selectedCircles.first!)
                        }
                    }) {
                        Image("minus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    
                    Button(action: {
                        if selectedCircles.count < 8 {
                            selectedCircles.insert(selectedCircles.count + 1)
                        }
                    }) {
                        Image("plss")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 118, height: 133)
                            .padding(.top, 20) // تقليل padding
                            .padding(.horizontal, -10)
                    }
                }
                .padding(.top, 20) // تقليل padding

                // Verify answer button (replaced with an image button)
                Button(action: {
                    checkAnswer()
                }) {
                    Image("okay") // Replace with your image name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 50) // Adjusted size for better fitting
                }
                .padding(.top, 50) // تقليل padding
            }
        }
    }

    // Function to handle the circle selection
    func numberedCircle(number: Int, x: CGFloat, y: CGFloat) -> some View {
        Button(action: {
            if selectedCircles.contains(number) {
                selectedCircles.remove(number)
            } else {
                selectedCircles.insert(number)
            }
        }) {
            Image("yourImageName")  // Replace with your image name for the circle
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .opacity(selectedCircles.contains(number) ? 1.0 : 0.5)  // Adjust opacity when selected
        }
        .offset(x: x, y: y)
    }

    // Function to check the answer
    func checkAnswer() {
        if selectedCircles.count == 8 {
            playSound(isCorrect: true) // Play success sound
        } else {
            playSound(isCorrect: false) // Play failure sound
        }
    }

    // Function to play sound based on answer correctness
    func playSound(isCorrect: Bool) {
        let soundName = isCorrect ? "success" : "failure"
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
    }
}

#Preview {
    Level31View()
}
