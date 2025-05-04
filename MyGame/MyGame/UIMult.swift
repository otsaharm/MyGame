import SwiftUI

struct UIMult: View {
    @Binding var skipCont: Int
    let answers: [String]
    let correctIndex: Int
    let questionText: String // معلمة السؤال
    let questionNumber: Int // معلمة رقم السؤال

    @State private var selectedAnswer: Int? = nil
    @State private var skipCount: Int = 0
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
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    Image("BUTTON.HOME")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.leading, 16) // ضبط المسافة إلى 16
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            Image("HEART")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(.trailing, 16) // ضبط المسافة إلى 16
                }
                .padding(.top, 70) // إضافة مسافة من الأعلى (إذا لزم الأمر)

                VStack(spacing: 50) {
                    HStack {
                        Image("PAGENUMBER")
                            .resizable()
                            .frame(width: 42, height: 42)
                            .overlay(
                                Text("\(questionNumber)") // عرض رقم السؤال هنا
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .padding(.leading, 32)
                        Spacer()
                    }
                    Text(questionText) // هنا نعرض النص
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
                
                // Skip Bar
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
        .ignoresSafeArea()
    }
    
    func answerButton(index: Int) -> some View {
        Button(action: {
            selectedAnswer = index
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
                    .padding(.horizontal, 8)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    @State var testSkip = 0
    let answers = ["", "", "", ""]
    let questionText = ""
    let questionNumber = 47 // رقم السؤال
    return UIMult(skipCont: $testSkip, answers: answers, correctIndex: 5, questionText: questionText, questionNumber: questionNumber)
}
