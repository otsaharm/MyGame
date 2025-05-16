//
import SwiftUI

struct question14: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = [
            "روح لسؤال 15",
            "روح لسؤال 14",
            "روح لسؤال 17",
            "روح لسؤال 16"
        ]
        let correctAnswerIndex = 0
        let questionText = "نتمنى انك كنت مركز لرقم السؤال"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: "?"
        )
    }
}

#Preview {
    question14()
}
