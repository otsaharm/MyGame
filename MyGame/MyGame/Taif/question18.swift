import SwiftUI

struct question18: View {
    @State private var skipCount = 0
    var onNext: () -> Void   // أضف هذا المتغير

    var body: some View {
        let answers = [
            "في الصحراء مع \n فنجال القهوة",
            "في ديوان المتنبي",
            "فوق السطح\n جنب المكيف",
            "داخل مشط الحلاق"
        ]
        let correctAnswerIndex = 3
        let questionText = "أين يمكن أن تجد بيت الشعر؟"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: "١٨",
            onCorrect: onNext // عند الإجابة الصحيحة انتقل للسؤال 19
        )
    }
}

#Preview {
    question18(onNext: {})
}
