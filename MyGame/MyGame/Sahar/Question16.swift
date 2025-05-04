import SwiftUI
struct Question16: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["تفاحة", "برتقال", "موز", "عنب"]
        let correctAnswerIndex = 1
        let questionText = "ما هي الفاكهة؟"
        let questionNumber: Int // ← تضيف هذا

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: 16
        )
    }
}

struct Question16_Previews: PreviewProvider {
    static var previews: some View {
        Question16()
    }
}
