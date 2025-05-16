import SwiftUI

struct Question23: View {
    @State private var skipCount = 0
    var onNext: () -> Void = {}

    var body: some View {
        let answers = ["مرة كبير", "كبير", "∞", "راسي"]
        let questionText = "اجابة هذا السؤال كبيرة مره"
        let questionNumber = "٢٣"
        let correctAnswerIndex = 3 // "∞"

        return UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // عند الإجابة الصحيحة انتقل للسؤال 24
        )
    }
}

#Preview {
    Question23(onNext: {})
}

