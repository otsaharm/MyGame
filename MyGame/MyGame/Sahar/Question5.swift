import SwiftUI

struct Question5: View {
    @State private var skipCount = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    @State private var isAnswerPressed = false

    var body: some View {
        let question = Question(
            id: 5,
            type: "multiple-choice",
            question: "اضغط على الجواب.",
            options: ["خارج الخدمه", "خارج الخدمة", "خارج الخدمة", "خارج الخدمه"],
            correctAnswer: 2
        )

        ZStack {
            UIforAll(skipCount: $skipCount) {
                VStack(spacing: 20) {
                    HStack {
                        Text("الجواب")
                            .font(.title2)
                            .foregroundColor(isAnswerPressed ? .green : .black)
                            .onTapGesture {
                                if selectedAnswer == nil {
                                    isAnswerPressed = true
                                    selectedAnswer = question.correctAnswer
                                    showFeedback = true
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        showFullScreenFeedback = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation(.easeOut(duration: 0.3)) {
                                            showFullScreenFeedback = false
                                            selectedAnswer = nil
                                            showFeedback = false
                                            isAnswerPressed = false
                                        }
                                    }
                                }
                            }

                        Text("اضغط على ")
                            .font(.title2)
                            .foregroundColor(.black)
                    }

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<question.options.count, id: \.self) { index in
                            Button(action: {
                                selectedAnswer = index
                                showFeedback = true
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    showFullScreenFeedback = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(.easeOut(duration: 0.3)) {
                                        showFullScreenFeedback = false
                                        selectedAnswer = nil
                                        showFeedback = false
                                    }
                                }
                            }) {
                                ZStack {
                                    Text(question.options[index])
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            selectedAnswer == index ?
                                                (index == question.correctAnswer ? Color.green : Color.red) :
                                                Color.white
                                        )
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )

                                    if showFeedback && selectedAnswer == index {
                                        Image(systemName: index == question.correctAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .blur(radius: showFullScreenFeedback ? 3 : 0)
            }

            if showFullScreenFeedback, let selected = selectedAnswer {
                FullScreenFeedbackView(isCorrect: selected == question.correctAnswer)
            }
        }
    }
}

struct FullScreenFeedbackView: View {
    let isCorrect: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 200))
                .foregroundColor(isCorrect ? .green : .red)
        }
    }
}

// Preview
#Preview {
    Question5()
}
