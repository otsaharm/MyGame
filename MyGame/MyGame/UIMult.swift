import SwiftUI

struct UIMult: View {
    @Binding var skipCont: Int
    let answers: [String]
    let correctAnswerIndex: Int
    let questionText: String
    let questionNumber: String
    var imageName: String? = nil
    var showColorHints: Bool = false // ✅ مضاف لدعم التلميحات اللونية
    var onCorrect: () -> Void = {}

    @State private var selectedAnswer: Int? = nil
    @State private var skipCount: Int = 0
    @State private var showHomeConfirmation = false
    @State private var navigateToStartPage = false
    @State private var remainingHearts = 3
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
                            ForEach(0..<remainingHearts, id: \.self) { _ in
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
                                        playSound(for: true)
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

    // ✅ زر الإجابة مع منطق عرض التلميحات اللونية
    func answerButton(index: Int) -> some View {
        Button(action: {
            guard !showColorHints else { return }

            if selectedAnswer == nil {
                selectedAnswer = index

                if index == correctAnswerIndex {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        onCorrect()
                    }
                } else {
                    withAnimation {
                        remainingHearts = max(0, remainingHearts - 1)
                    }
                }

                playSound(for: index == correctAnswerIndex)
            }
        }) {
            ZStack {
                if showColorHints {
                    if index == correctAnswerIndex {
                        // الزر الصحيح أخضر خافت
                        Image("BUTTON.REGULAR")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.green.opacity(0.5))
                            .frame(width: 151.68, height: 81)
                    } else {
                        // الأزرار الخاطئة حمراء خافتة
                        Image("BUTTON.REGULAR")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.red.opacity(0.5))
                            .frame(width: 151.68, height: 81)
                    }
                } else if selectedAnswer == index && index == correctAnswerIndex {
                    Image("BUTTON.CORRECT")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                } else {
                    Image("BUTTON.REGULAR")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                }

                let answer = answers[index]
                Text(answer)
                    .font(.system(size: 27, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    UIMult(
        skipCont: .constant(0),
        answers: ["", "", "", ""],
        correctAnswerIndex: 3,
        questionText: "ناظر زين!!",
        questionNumber: "٤",
        showColorHints: true // ✅ جرب عرض الألوان في البداية
    )
}
