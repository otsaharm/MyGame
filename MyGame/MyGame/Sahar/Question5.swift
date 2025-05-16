import SwiftUI

struct Question5: View {
    @State private var skipCount = 0
    @State private var selectedAnswer: Int? = nil
    var onNext: () -> Void   // متغير الانتقال للسؤال السادس

    var body: some View {
        let answers = ["خارج الخدمة", "خارج الخدمة", "خارج الخدمة", "خارج الخدمة"]
        let questionText = "اضغط على "
        let questionNumber = "٥"
        let correctAnswerIndex = 7 // هذا لن يستخدم فعليًا هنا

        VStack(spacing: 16) {
            // "الجواب" هو الزر الصحيح
            Text("الجواب")
                .font(.title2)
                .padding()
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .onTapGesture {
                    // عند الضغط على كلمة الجواب انتقل للسؤال السادس
                    onNext()
                }

            UIMult(
                skipCont: $skipCount,
                answers: answers,
                correctAnswerIndex: correctAnswerIndex, // لن يتم استخدامه هنا
                questionText: questionText,
                questionNumber: questionNumber
                // لا تمرر onCorrect هنا لأن الخيارات ليست هي الجواب
            )
        }
        .padding()
    }
}

struct Question5_Previews: PreviewProvider {
    static var previews: some View {
        Question5(onNext: {})
    }
}
