import SwiftUI

struct Question9: View {
    @State private var skipCount = 0

    var body: some View {
        let answers = ["سعف", "جذور", "رطب", "جذع"]
        let questionText = "النخلة"
        let questionNumber = 9
        let correctAnswerIndex = 2 // مؤشر الإجابة الصحيحة ("جذع")

        UIMult(
            skipCont: $skipCount,            // تمرير skipCont
            answers: answers,                // تمرير قائمة الإجابات
            correctAnswerIndex: correctAnswerIndex,  // تمرير الإجابة الصحيحة
            questionText: questionText,      // تمرير نص السؤال
            questionNumber: questionNumber,  // تمرير رقم السؤال
            imageName: "root"                // تمرير صورة الجذر (اختياري)
        )


    }
}

struct Question9_Previews: PreviewProvider {
    static var previews: some View {
        Question9()
    }
}
