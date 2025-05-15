import SwiftUI

struct Question44: View {
    @State private var skipCont: Int = 0
    let answers = [
        "خشم",
        "رموش",
        "ت", // correct
        "مسافة"
    ]
    let correctIndex = 2
    let questionText = "وشو من الاختيارات موجود تحت العين؟"
    let questionNumber = "٤٤"
    
    var body: some View {
        UIMult(
            skipCont: $skipCont, // ✅ تم تصحيحه هنا
            answers: answers,
            correctAnswerIndex: correctIndex,
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}
#Preview {
    Question44()
}
