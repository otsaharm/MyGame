import SwiftUI

struct question18: View {
    @State private var skipCount = 0

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
            correctAnswerIndex: correctAnswerIndex, // ✅ صححنا الاسم
            questionText: questionText,
            questionNumber: "١٨"
        )
    }
}

#Preview {
    question18()
}
