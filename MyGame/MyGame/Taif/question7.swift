
import SwiftUI

struct question7: View {
    @State private var skipCount = 2

    var body: some View {
        let answers = [
            "الملكة ترسلك شكر رسمي",
            "تصير انت ملك النمل",
            "النمل يقولك يا شطور", // <-- هذا هو الصحيح
            "تنطرد لانك كثير"
        ]
        let correctAnswerIndex = 2 // <-- عدلنا هنا ليطابق الخيار الصحيح
        let questionText = "اذا فزت بسباق نمل وش بيصير؟"
        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: 7
        )
    }
}

#Preview {
    question7()
}
