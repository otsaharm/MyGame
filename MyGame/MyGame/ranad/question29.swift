import SwiftUI

struct Question29: View {
    @State private var skipCont: Int = 0
    let answers = [
        "ما اعبيه", // left down (correct)
        "احط كيس جوا", // left up
        "اسكر الفتحة", // right down
        "ارفع الفتحة" // right up
    ]
    let correctIndex = 0
    let questionText = "لو عندك دلو فيه فتحة من تحت، وش تسوي عشان ماينكب المويه"
    let questionNumber = "٢٩"
    var onNext: () -> Void = {} // أضف هذا المتغير

    var body: some View {
        UIMult(
            skipCont: $skipCont,
            answers: answers,
            correctAnswerIndex: correctIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // عند الإجابة الصحيحة انتقل للسؤال 30
        )
    }
}

#Preview {
    Question29()
}
