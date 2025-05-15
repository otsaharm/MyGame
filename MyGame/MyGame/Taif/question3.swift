import SwiftUI

struct question3: View {
    @State private var skipCount = 0

    var body: some View {
        UIMult(
            skipCont: $skipCount,
            answers: ["هـ", "كان هذا السؤال مر علي 🤔", "ل", "ذ"],
            correctAnswerIndex: 3, // "ذ" هو الصحيح (الزر الرابع)
            questionText: "وش تاسع حرف من الحروف الهجائية",
            questionNumber: "٣"        )
    }
}

#Preview {
    question3()
}
