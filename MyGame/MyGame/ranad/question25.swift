import SwiftUI

struct Question25: View {
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    
    let question = Question(
        id: 25,
        type: "multiple-choice",
        question: "كيف تقدر تقسم تفاحه على ثلاث اشخاص ويكون نصيب كل واحد نص؟",
        options: ["نقسم تفاحتين ونقولهم يتفاهمون بينهم", "نكلم التفاحه ونسالها :انتي تفاحه؟ ترد: انا تفاحه ونص"
                  , "نقسم التفاحه نصين و نخلي الثالث يتفرج", "ياخذها واحد ويقسمها عليهم بالنيه الطيب"],
        correctAnswer: 0
    )
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(question.question)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack(spacing: 20) {
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
                .padding(.horizontal)
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
    Question25()
} 
