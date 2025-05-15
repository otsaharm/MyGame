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
        let correctAnswerIndex = 2
        let questionText = "اذا فزت بسباق نمل وش بيصير؟"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: "٧"
        )
    }
}

#Preview {
    question7()
}
