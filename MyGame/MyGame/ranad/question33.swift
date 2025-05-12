import SwiftUI

struct Question33: View {
    @State private var skipCont: Int = 0
    let answers = [
        "كأن هذا السؤال قد مر علي🤔",
        "ذ", // correct
        "ر",
        "هـ"
    ]
    let correctIndex = 1
    let questionText = "وش تاسع حرف من الحروف الابجدية؟"
    let questionNumber = 33
    
    var body: some View {
        UIMult(
            skipCont: $skipCont,
            answers: answers,
            correctIndex: correctIndex,
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

#Preview {
    Question33()
} 
