import SwiftUI
struct question1: View {
    @State private var skipCount = 0
    var onNext: () -> Void

    var body: some View {
        let answers = ["زي كذا", "بحذر", "بروقان", "بثقة"]
        let correctAnswerIndex = 0
        let questionText = "كيف تبدأ اللعبة ؟"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: "١",
            onCorrect: onNext // مرر الدالة هنا
        )
    }
}

#Preview {
    question1(onNext: {})
}
