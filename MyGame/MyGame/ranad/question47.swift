import SwiftUI

struct Question47: View {
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    
    let question = Question(
        id: 47,
        type: "multiple-choice",
        question: "انتبه! ترا اذا قلته بينكسر!!",
        options: ["المرايه", "رقبة الثور", "مواعين البيت", "الصمت"],
        correctAnswer: 0
    )
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
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
    Question47()
} 
