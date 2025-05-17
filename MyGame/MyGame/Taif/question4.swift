import SwiftUI

struct question4: View {
    @State private var skipCount = 0
    @State private var showColors = true
    var onNext: () -> Void

    let correctIndex = 3
    let questionText = "ناظر زين!!"
    let questionNumber = "٤"
    let answers = ["", "", "", ""]

    var body: some View {
        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            showColorHints: showColors,
            onCorrect: {
                onNext()
            }
        )
        .onAppear {
            // إخفاء الألوان بعد ثانية واحدة
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showColors = false
                }
            }
        }
    }
}

#Preview {
    question4(onNext: {})
}

