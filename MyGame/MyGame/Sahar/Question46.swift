import SwiftUI

struct Question46: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["مافي تواصل", "يزعل الرواتر", "العالم ينهار", "تنام بدري"]
        let questionText = "وش يصير إذا انقطع النت"
        let questionNumber = "٤٦"
        let correctAnswerIndex = 3 // ✅ الاسم الصحيح
        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ الاسم الصحيح
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

struct Question46_Previews: PreviewProvider {
    static var previews: some View {
        Question46()
    }
}
