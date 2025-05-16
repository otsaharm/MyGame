import SwiftUI
import AVFoundation

struct QuestionView: View {
    @Binding var skipCount: Int
    @State private var answer: String = ""
    @State private var isCorrect = false
    @State private var audioPlayer: AVAudioPlayer? // لتخزين اللاعب الصوتي

    let questionNumber = 30
    let questionText = "كم عدد الشهور اللي فيها ٢٨ يوم؟"
    let correctAnswer = "١٢"
    let numberButtons = ["مسح","٩", "٨", "٧", "٦", "٥", "٤", "٣", "٢", "٠", "١","تم"]
    @State private var pageNumber: String = "٣٠"
    var body: some View {
        ZStack {
            UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
                VStack(spacing: 10) {

                    

                    // نص السؤال فقط (بدون صورة)
                    Text(questionText)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)

                    // مربع الإجابة داخل صورة box
                    ZStack {
                        Image("box")
                            .resizable()
                            .frame(width: 300, height: 100)

                        Text(answer)
                            .font(.largeTitle)
                            .foregroundColor(.black)

                    
                    }

                    Spacer()

                    // أزرار الأرقام
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 16) {
                        ForEach(numberButtons, id: \.self) { number in
                            Button(action: {
                                if number == "مسح" {
                                    answer = "" // مسح الإجابة
                                    isCorrect = false
                                } else if number == "تم" {
                                    // تحقق من الإجابة
                                    checkAnswer()
                                } else if answer.count < 3 {
                                    answer += number
                                    isCorrect = (answer == correctAnswer)
                                }
                            }) {
                                ZStack {
                                    Image("numper")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .shadow(radius: 3)

                                    Text(number)
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }

                        if numberButtons.count % 4 != 0 {
                            ForEach(0..<(4 - numberButtons.count % 4), id: \.self) { _ in
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding(.top, 40)
            }
        }
    }

    // دالة للتحقق من الإجابة وتشغيل الصوت
    func checkAnswer() {
        if answer == correctAnswer {
            isCorrect = true
            playSound(isCorrect: true) // تشغيل صوت النجاح
        } else {
            isCorrect = false
            playSound(isCorrect: false) // تشغيل صوت الخطأ
        }
    }

    // دالة لتشغيل الصوت
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
    @State var previewSkip = 0
    return QuestionView(skipCount: $previewSkip)
}
