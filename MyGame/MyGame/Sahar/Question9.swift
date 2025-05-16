import SwiftUI

struct Question9: View {
    @State private var skipCount = 0
    var onNext: () -> Void

    var body: some View {
        let answers = ["سعف", "جذور", "رطب", "جذع"]
        let questionText = "النخلة"
        let questionNumber = "٩"
        let correctAnswerIndex = 2 // "رطب"

        UIMult(
            skipCont: $skipCount,
            answers: answers,
            correctAnswerIndex: correctAnswerIndex,
            questionText: questionText,
            questionNumber: questionNumber,
            imageName: "root",
            onCorrect: onNext // هنا يتم تمرير onNext للانتقال التلقائي
        )
    }
}

struct Question9_Previews: PreviewProvider {
    static var previews: some View {
        Question9(onNext: {})
    }
}
