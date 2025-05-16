//
//
//
import SwiftUI
struct question1: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["زي كذا", // correct
                       "بحذر",
                       "بروقان",
                       "بثقة"]
        let correctAnswerIndex = 0
        let questionText = "كيف تبدأ اللعبة ؟"
        let questionNumber: Int // ← تضيف هذا

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: "١"
        )
    }
}


#Preview {
    question1()
}
