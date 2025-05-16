
import SwiftUI

struct Question32: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["امك", "المعلم", "الصافرة", "الحكم"]
        let questionText = "هيبه وتأمر على عشرين رجال وحرمه؟"
        let questionNumber = "٣٢"
        let correctAnswerIndex = 2 // ✅ الاسم الصحيح
        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex, // ✅ الاسم الصحيح
            questionText: questionText,
            questionNumber: questionNumber
        )
    }
}

struct Question32_Previews: PreviewProvider {
    static var previews: some View {
        Question32()
    }
}
