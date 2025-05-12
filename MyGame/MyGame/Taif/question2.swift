
import SwiftUI
struct question2: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = [ "هاه؟",
                        "إجابة",
                        "بالمقلوب",
                        "بيط"]
        let correctAnswerIndex = 3
        let questionText = "بولقملاب لاؤسلا ةباجا"
        let questionNumber: Int // ← تضيف هذا

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: 2
        )
    }
}





#Preview {
    question2()
}
