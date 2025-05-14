import SwiftUI

struct question11: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = [
            "خمسة",
            "واحدة",
            "ولا وحدة",
            "تعتمد على الحجم"
        ]
        let correctAnswerIndex = 1
        let questionText = "كم عدد الموزات اللي تقدر تأكلها على معدة فاضية؟"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ صححنا الاسم
            questionText: questionText,
            questionNumber: 11
        )
    }
}

#Preview {
    question11()
}
