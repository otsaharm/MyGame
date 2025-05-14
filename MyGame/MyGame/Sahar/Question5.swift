import SwiftUI

struct Question5: View {
    @State private var skipCount = 0
    @State private var selectedAnswer: Int? = nil

    var body: some View {
        let answers = ["خارج الخدمة", "خارج الخدمة", "خارج الخدمة", "خارج الخدمة"]
        let questionText = "اضغط على "
        let questionNumber = 5
        let correctAnswerIndex = 7

        VStack(spacing: 16) {
            
            // "الجواب" فوق الخيارات مباشرة
            Text("الجواب")
                .font(.title2)
                .padding()
                .fontWeight(.bold)
                .foregroundColor(selectedAnswer == correctAnswerIndex ? .green : .blue)
.onTapGesture {
    selectedAnswer =
    correctAnswerIndex}
            UIMult(
                skipCont: $skipCount,
                answers: answers,
                correctAnswerIndex: correctAnswerIndex, // ✅ الاسم الصحيح
                questionText: questionText,
                questionNumber: questionNumber)
          
        }
        .padding()
    }
}

struct Question5_Previews: PreviewProvider {
    static var previews: some View {
        Question5()
    }
}
