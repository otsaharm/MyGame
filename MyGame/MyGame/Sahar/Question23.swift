import SwiftUI

struct Question23: View {
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    
    let question = Question(
        id: 23,
        type: "multiple-choice",
        question: "اجابة هذا السوال مرة كبير",
        options: ["مرة كبير", "-١ حياة", "راسك", "∞"],
        correctAnswer: 2
    )
    
    var body: some View {
        ZStack {
            VStack(spacing: 2) {
                Text(question.question)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
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
                                // تعديل النص داخل كل زر
                                if question.options[index] == "مرة كبير" {
                                    Text(question.options[index])
                                        .bold()
                                        .font(.largeTitle)
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
                                } else if question.options[index] == "∞" {
                                    Text(question.options[index])
                                        .font(.system(size: 90)) // تكبير علامة الانفنتي
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            selectedAnswer == index ?
                                            (index == question.correctAnswer ? Color.green : Color.red) :
                                            Color.white
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.blue, lineWidth: 2)
                                        )
                                } else {
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
                                }
                                
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
            
            if showFullScreenFeedback, let selected = selectedAnswer {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    Image(systemName: selected == question.correctAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 200))
                        .foregroundColor(selected == question.correctAnswer ? .green : .red)
                        .scaleEffect(showFullScreenFeedback ? 1 : 0.5)
                }
            }
        }
    }
}

#Preview {
    Question23()
}
