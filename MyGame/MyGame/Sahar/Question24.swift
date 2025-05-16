import SwiftUI
import AVFoundation

struct Question24: View {
    @State private var skipCount = 0
    @State private var selectedAnswer: Int? = nil
    @State private var didTapQuestionNumber = false
    @State private var showFullScreenFeedback = false
    @State private var isCorrectAnswer = false
    @State private var audioPlayer: AVAudioPlayer? // تم إضافة @State هنا

    let answers = ["١٨", "٢٣،٩٣١", "١٢", "مو موجود!!!"]
    let questionText = "٢٥ - ١ = ؟"
    let questionNumber = 24
    let maxSkips = 6

    var skipBarImageName: String {
        switch skipCount {
        case 0: return "SKIP.BAR.1"
        case 1: return "SKIP.BAR.2"
        case 2: return "SKIP.BAR.3"
        case 3, 4: return "SKIP.BAR.4"
        default: return "SKIP.BAR.1"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Image("BUTTON.HOME")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.leading, 16)
                        Spacer()
                        HStack(spacing: 4) {
                            ForEach(0..<3, id: \.self) { _ in
                                Image("HEART")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.top, 70)

                    VStack(spacing: 50) {
                        HStack {
                            Image("PAGENUMBER")
                                .resizable()
                                .frame(width: 42, height: 42)
                                .overlay(
                                    Text("\(questionNumber)")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(didTapQuestionNumber ? .green : .white)
                                        .onTapGesture {
                                            if !showFullScreenFeedback {
                                                didTapQuestionNumber = true
                                                isCorrectAnswer = true
                                                playSound(isCorrect: true)
                                                showFullScreenFeedback = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                    withAnimation {
                                                        showFullScreenFeedback = false
                                                    }
                                                }
                                            }
                                        }
                                )
                                .padding(.leading, 32)
                            Spacer()
                        }

                        Text(questionText)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 10)

                        VStack(spacing: 20) {
                            HStack(spacing: 24) {
                                answerButton(index: 0)
                                answerButton(index: 1)
                            }
                            HStack(spacing: 24) {
                                answerButton(index: 2)
                                answerButton(index: 3)
                            }
                        }
                        .padding(.horizontal, 16)
                        .environment(\.layoutDirection, .rightToLeft)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity, alignment: .center)

                    Spacer(minLength: 150)

                    ZStack {
                        Image(skipBarImageName)
                            .resizable()
                            .frame(width: 216, height: 52)
                        let slotOffsets: [CGFloat] = [87, 29, -20, -80]
                        if skipCount < maxSkips {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    skipCount += 1
                                }
                            }) {
                                Image("SKIP.BUTTON")
                                    .resizable()
                                    .frame(width: 56.5, height: 56.5)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .offset(x: slotOffsets[skipCount], y: 1)
                        }
                    }
                    .padding(.bottom, 32)
                    .padding(.trailing, -100)
                }

                if showFullScreenFeedback && didTapQuestionNumber {
                    FullScreenFeedbackView(isCorrect: isCorrectAnswer)
                }
            }
        }
        .ignoresSafeArea()
    }

    func answerButton(index: Int) -> some View {
        Button(action: {
            selectedAnswer = index
            if index == questionNumber - 1 {
                isCorrectAnswer = true
                playSound(isCorrect: true)
            } else {
                isCorrectAnswer = false
                playSound(isCorrect: false)
            }
        }) {
            ZStack {
                if selectedAnswer == index && isCorrectAnswer {
                    Image("BUTTON.CORRECT")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                } else {
                    Image("BUTTON.REGULAR")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                }

                Text(answers[index])
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)

                if selectedAnswer == index && isCorrectAnswer {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(showFullScreenFeedback)
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

struct FullScreenFeedbackView: View {
    let isCorrect: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 200))
                .foregroundColor(isCorrect ? .green : .red)
        }
    }
}

#Preview {
    Question24()
}
