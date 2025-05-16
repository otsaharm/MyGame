import SwiftUI

struct Question33: View {
    @State private var skipCont: Int = 0
    var onNext: () -> Void = {} // متغير الانتقال

    let answers = [
        "كأن هذا السؤال قد مر علي🤔",
        "ذ", // correct
        "ر",
        "هـ"
    ]
    let correctIndex = 1
    let questionText = "وش تاسع حرف من الحروف الابجدية؟"
    let questionNumber = "٣٣"
    
    var body: some View {
        UIMult(
            skipCont: $skipCont,
            answers: answers,
            correctAnswerIndex: correctIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // مرر المتغير هنا
        )
    }
}

#Preview {
    Question33()
}
