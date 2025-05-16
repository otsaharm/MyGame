import SwiftUI

struct Question39: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["اذا اشتاق", "اذا شافك", "اذا انصهر", "اذا خاف"]
        let questionText = "متى يذوب الحديد"
        let questionNumber = "٣٩"
        let correctAnswerIndex = 0// مؤشر الإجابة الصحيحة ("اذا انصهر")

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ تم التصحيح هنا
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

struct Question39_Previews: PreviewProvider {
    static var previews: some View {
        Question39()
    }
}
