import SwiftUI

struct Question35: View {
    @State private var skipCont: Int = 0
    let answers = [
        "تغرق",
        "ياكلونها السمك",
        "تصير عصير طماطم",
        "تروح برحلة بحرية" // correct
    ]
    let correctIndex = 3
    let questionText = "اذا حطيت حبة طماطم في البحر وش بيصير لها ؟"
    let questionNumber = "٣٥"
    var onNext: () -> Void = {} // متغير الانتقال
    
    var body: some View {
        UIMult(
            skipCont: $skipCont, // ✅ تم تصحيحه هنا
            answers: answers,
            correctAnswerIndex: correctIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            onCorrect: onNext // مرر المتغير هنا
        )
    }
}

#Preview {
    Question35()
} 
