import SwiftUI

struct Question47: View {
    @State private var selectedAnswer: Int? = nil
    @State private var skipCount: Int = 0
    @State private var circleOffset: CGFloat = 0
    let maxSkips = 4
    
    let answers = [
        "المرايه",
        "رقبة الثور",
        "مواعين البيت",
        "الصمت" // correct
    ]
    let correctIndex = 3
    
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
                // Top bar just below dynamic island
                HStack {
                    Image("BUTTON.HOME")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.leading, 24)
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            Image("HEART")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(.trailing, 24)
                }
                .padding(.top, 55)
                
                Spacer(minLength: 0)
                VStack(spacing: 50) {
                    // Question number
                    HStack {
                        Image("PAGENUMBER")
                            .resizable()
                            .frame(width: 42, height: 42)
                            .overlay(
                                Text("٤٧")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .padding(.leading, 32)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // Question text
                    Text("انتبه! ترا اذا قلته بينكسر!!")
                        .font(.system(size: 24, weight: .regular))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    
                    // Answer buttons grid
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
                // Skip Bar (pixel-perfect, fixed slot positions)
                ZStack {
                    Image(skipBarImageName)
                        .resizable()
                        .frame(width: 216, height: 52)
                    // Slot positions for the button (right to left)
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
    Question47()
} 
