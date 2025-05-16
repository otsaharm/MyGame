import SwiftUI

struct Question32: View {
    @State private var skipCount = 0
    var onNext: () -> Void = {} // متغير الانتقال

    var body: some View {
        let answers = ["امك", "المعلم", "الصافرة", "الحكم"]
        let questionText = "هيبه وتأمر على عشرين رجال وحرمه؟"
        let questionNumber = "٣٢"
        let correctAnswerIndex = 2 // ✅ الاسم الصحيح
        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // استخدم onCorrect بدلاً من onNext
        )
    }
}

struct Question32_Previews: PreviewProvider {
    static var previews: some View {
        Question32()
    }
}
