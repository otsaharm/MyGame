import SwiftUI

struct Question16: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["كيلو قطن", "متساوين", "خدك", "كيلو حديد"]
        let questionText = "أيهم أثقل؟ كيلو قطن ولا كيلو حديد؟"
        let questionNumber = 16
        let correctAnswerIndex = 1 // مؤشر الإجابة الصحيحة ("متساوين")

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ الاسم الصحيح هنا
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

struct Question16_Previews: PreviewProvider {
    static var previews: some View {
        Question16()
    }
}
