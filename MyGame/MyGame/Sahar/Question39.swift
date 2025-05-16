import SwiftUI

struct Question39: View {
    @State private var skipCount = 0
    var onNext: () -> Void = {} // متغير الانتقال

    var body: some View {
        let answers = ["اذا اشتاق", "اذا شافك", "اذا انصهر", "اذا خاف"]
        let questionText = "متى يذوب الحديد"
        let questionNumber = "٣٩"
        let correctAnswerIndex = 0// مؤشر الإجابة الصحيحة ("اذا انصهر")

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // مرر المتغير هنا
        )
    }
}

struct Question39_Previews: PreviewProvider {
    static var previews: some View {
        Question39()
    }
}
