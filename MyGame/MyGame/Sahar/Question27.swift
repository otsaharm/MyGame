import SwiftUI
import AVFAudio



// MARK: - Question27 View
struct Question27: View {
    @Binding var skipCont: Int
    let answers: [String] // 4 عناصر – واحد منهم يكون للصورة ويكون محتواه ""
    let questionNumber: Int
    var imageName: String? = nil

    @State private var selectedAnswer: Int? = nil
    @State private var skipCount: Int = 0
    let maxSkips = 4
    @State private var didTapQuestionNumber = false
    @State private var showFullScreenFeedback = false

    var correctIndex: Int {
        return 1 // ← الطيارة في الخيار الثاني
    }

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
                VStack(spacing: -20) {
                    HStack {
                        Image("BUTTON.HOME")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.leading, 16)
                        Spacer()
                        HStack(spacing: 4) {
                            ForEach(0..<3) { _ in
                                Image("HEART")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.top, 70)

                    VStack(spacing: 20) {
                        HStack {
                            Image("PAGENUMBER")
                                .resizable()
                                .frame(width: 42, height: 42)
                                .overlay(
                                    Text("\(questionNumber)")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(didTapQuestionNumber ? .green : .white)
                                )
                                .padding(.leading, 32)
                            Spacer()
                        }

                        Text("وش أقرب شي لنا؟")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)

                        if let imageName = imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .padding(.top, 90)
                                .padding(.bottom, -10)
                        }

                        VStack(spacing: 20) {
                            answerButton(index: 0)
                            imageButton(index: 1) // ← صورة الطيارة هنا
                            answerButton(index: 2)
                            answerButton(index: 3)
                        }
                        .padding(.horizontal, 30)
                        .environment(\.layoutDirection, .rightToLeft)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity, alignment: .center)

                    Spacer(minLength: 10)

                    ZStack {
                        Image(skipBarImageName)
                            .resizable()
                            .frame(width: 216, height: 52)
                        let slotOffsets: [CGFloat] = [87, 29, -20, -80]
                        if skipCount < maxSkips {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    if skipCount < maxSkips {
                                        skipCount += 1
                                    }
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
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .ignoresSafeArea()
    }

    func answerButton(index: Int) -> some View {
        Button(action: {
            selectedAnswer = index
            playSound(for: index == correctIndex)
        }) {
            ZStack {
                if selectedAnswer == index && index == correctIndex {
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
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(showFullScreenFeedback)
    }

    func imageButton(index: Int) -> some View {
        Button(action: {
            selectedAnswer = index
            playSound(for: index == correctIndex)
        }) {
            ZStack {
                Image(selectedAnswer == index && index == correctIndex ? "BUTTON.CORRECT" : "BUTTON.REGULAR")
                    .resizable()
                    .frame(width: 151.68, height: 81)

                Image("plan")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
            }
            .frame(width: 151.68, height: 90)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(showFullScreenFeedback)
    }
}

// MARK: - Preview
#Preview {
    @State var testSkip = 0
    let answers = ["القمر", "", "الشمس", "زحل"] // ← الطيارة بدل ""

    return Question27(
        skipCont: $testSkip,
        answers: answers,
        questionNumber: 27
    )
}
