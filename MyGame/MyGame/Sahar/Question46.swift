import SwiftUI

struct Question46: View {
    @State private var skipCount = 0
    var onNext: () -> Void = {} // متغير الانتقال

    var body: some View {
        let answers = ["مافي تواصل", "يزعل الرواتر", "العالم ينهار", "تنام بدري"]
        let questionText = "وش يصير إذا انقطع النت"
        let questionNumber = "٤٦"
        let correctAnswerIndex = 3 // ✅ الاسم الصحيح
        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ الاسم الصحيح
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // مرر المتغير هنا
        )
    }
}

struct Question46_Previews: PreviewProvider {
    static var previews: some View {
        Question46()
    }
}
