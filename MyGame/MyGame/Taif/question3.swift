

import SwiftUI

struct question3: View {
    @State private var skipCount = 0

    var body: some View {
        UIMult(
            skipCont: $skipCount,
            answers: ["هـ", "كان هذا السؤال مر علي 🤔", "ل", "ذ"],
            correctIndex: 3, // "ذ" هو الصحيح (الزر الرابع)
            questionText: "وش تاسع حرف من الحروف الهجائية",
            questionNumber: 3
        )
    }
}

#Preview {
    question3()
}
