import SwiftUI

struct question3: View {
    @State private var skipCount = 0
    var onNext: () -> Void   // أضف هذا المتغير

    var body: some View {
        UIMult(
            skipCont: $skipCount,
            answers: ["هـ", "كان هذا السؤال مر علي 🤔", "ل", "ذ"],
            correctAnswerIndex: 0, // "هـ" هو الصحيح (الزر الأول)
            questionText: "وش تاسع حرف من الحروف الهجائية",
            questionNumber: "٣",
            onCorrect: onNext // مرر الدالة هنا
        )
    }
}

#Preview {
    question3(onNext: {})
}
