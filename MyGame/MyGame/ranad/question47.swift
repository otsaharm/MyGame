import SwiftUI

struct Question47: View {
    @State private var skipCont: Int = 0
    let answers = [
        "المرايه",
        "رقبة الثور",
        "مواعين البيت",
        "الصمت" // correct
    ]
    let correctIndex = 3
    let questionText = "انتبه! ترا اذا قلته بينكسر!!"
    let questionNumber = "٤٧"
    
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
    Question47()
} 
