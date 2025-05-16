import SwiftUI
struct question2: View {
    @State private var skipCount = 0
    var onNext: () -> Void   // أضف هذا المتغير

    var body: some View {
        let answers = [ "هاه؟", "إجابة", "بالمقلوب", "بيط"]
        let correctAnswerIndex = 3
        let questionText = "بولقملاب لاؤسلا ةباجا"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: "٢",
            onCorrect: onNext // مرر الدالة هنا
        )
    }
}

#Preview {
    question2(onNext: {})
}
