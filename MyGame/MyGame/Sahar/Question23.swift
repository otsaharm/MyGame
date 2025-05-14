import SwiftUI

struct Question23: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["مرة كبير", "كبير", "∞", "راسي"]
        let questionText = "اجابة هذا السؤال كبيرة مره"
        let questionNumber = 23
        let correctAnswerIndex = 3 // "∞"

        return UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

#Preview {
    Question23()
}
