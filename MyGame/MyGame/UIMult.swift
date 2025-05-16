import SwiftUI

struct UIMult: View {
    @Binding var skipCont: Int
    let answers: [String]
    let correctAnswerIndex: Int
    let questionText: String
    let questionNumber: String
    var imageName: String? = nil

    @State private var selectedAnswer: Int? = nil
    @State private var skipCount: Int = 0
    @State private var showHomeConfirmation = false
    @State private var navigateToStartPage = false
    let maxSkips = 4

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
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            showHomeConfirmation = true
                        }) {
                            Image("BUTTON.HOME")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .padding(.leading, 16)
                        }
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

                    VStack(spacing: 50) {
                        HStack {
                            Image("PAGENUMBER")
                                .resizable()
                                .frame(width: 42, height: 42)
                                .overlay(
                                    Text("\(questionNumber)")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.white)
                                )
                                .padding(.leading, 32)
                            Spacer()
                        }

                        if let imageName = imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 80)
                                .padding(.top, 90)
                                .padding(.bottom, -100)
                        }

                        Text(questionText)
                            .font(.title)
                            .fontWeight(.semibold)
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
                                    if skipCount < maxSkips {
                                        skipCount += 1
                                        skipCont += 1
                                        playSound(for: true) // صوت التخطي
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
            .ignoresSafeArea()
            .alert("ودك ترجع للبيت؟", isPresented: $showHomeConfirmation) {
                Button("لا", role: .cancel) { }
                Button("اي", role: .none) {
                    navigateToStartPage = true
                }
            }
            .navigationDestination(isPresented: $navigateToStartPage) {
                StartPage()
            }
        }
    }

    func answerButton(index: Int) -> some View {
        Button(action: {
            selectedAnswer = index
            playSound(for: index == correctAnswerIndex) // صوت الإجابة
        }) {
            ZStack {
                if selectedAnswer == index && index == correctAnswerIndex {
                    Image("BUTTON.CORRECT")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                } else {
                    Image("BUTTON.REGULAR")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                }

                let answer = answers[index]
                if answer == "∞" {
                    Text("∞")
                        .font(.system(size: 100, weight: .heavy))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                } else if answer == "مرة كبير" {
                    Text("مرة كبير")
                        .font(.system(size: 42, weight: .heavy))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                } else {
                    Text(answer)
                        .font(.system(size: 27, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    UIMult(
        skipCont: .constant(0),
        answers: ["مرة كبير", "كبير", "∞", "راسي"],
        correctAnswerIndex: 2,
        questionText: "اجابة هذا السؤال كبيرة مره",
        questionNumber: "٢٣"
    )
}
