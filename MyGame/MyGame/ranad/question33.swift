import SwiftUI

struct Question33: View {
    @State private var selectedAnswer: Int? = nil
    
    let answers = [
        "كأن هذا السؤال قد مر علي🤔",
        "ذ", // correct
        "ر",
        "هـ"
    ]
    let correctIndex = 1
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top bar just below dynamic island
                HStack {
                    Image("BUTTON.HOME")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.leading, 24)
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            Image("HEART")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                    }
                    .padding(.trailing, 24)
                }
                .padding(.top, 50)
                
                Spacer(minLength: 0)
                VStack(spacing: 18) {
                    // Question number
                    HStack {
                        Image("PAGENUMBER")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .overlay(
                                Text("٣٣")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .padding(.leading, 32)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    
                    // Question text
                    Text("وش تاسع حرف من الحروف الابجدية؟")
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
                        .frame(height: 70)
                } else {
                    Image("BUTTON.REGULAR")
                        .resizable()
                        .frame(height: 70)
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
    Question33()
} 
