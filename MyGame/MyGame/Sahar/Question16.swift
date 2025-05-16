import SwiftUI

struct Question16: View {
    @State private var skipCount = 0
    var onNext: () -> Void   // أضف هذا المتغير

    var body: some View {
        let answers = ["كيلو قطن", "متساوين", "خدك", "كيلو حديد"]
        let questionText = "أيهم أثقل؟ كيلو قطن ولا كيلو حديد؟"
        let questionNumber = "١٦"
        let correctAnswerIndex = 1 // مؤشر الإجابة الصحيحة ("متساوين")

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // عند الإجابة الصحيحة انتقل للسؤال 18
        )
    }
}

struct Question16_Previews: PreviewProvider {
    static var previews: some View {
        Question16(onNext: {})
    }
}
