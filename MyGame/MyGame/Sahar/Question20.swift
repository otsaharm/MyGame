import SwiftUI

struct Question20: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["١+ تخطي", "تجاهل", "-١ حياة", "١+ حياة"]
        let questionText = "الخيار لك فلها 😉"
        let questionNumber = "٢٠"
        let correctAnswerIndex = 3 // مؤشر الإجابة الصحيحة ("١+ حياة")

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ الاسم الصحيح هنا
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

struct Question20_Previews: PreviewProvider {
    static var previews: some View {
        Question20()
    }
}
