import SwiftUI

struct Question30: View {
    @State private var answer: String = ""
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    @State private var isCorrectAnswer = false

    let question = Question(
        id: 30,
        type: "number-input",
        question: "كم عدد الشهور اللي ٢٨ يوم",
        options: [],
        correctAnswer: 12
    )

    let numberPadKeys = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["مسح", "0", "ادخال"]
    ]

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(question.question)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                TextField("", text: $answer)
                    .keyboardType(.numberPad)
                    .frame(width: 250, height: 80)
                    .border(Color.gray, width: 2)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .disabled(true)

                VStack(spacing: 10) {
                    ForEach(numberPadKeys, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { key in
                                Button(action: {
                                    handleNumberPadInput(key)
                                }) {
                                    Text(key)
                                        .font(.title2)
                                        .frame(width: key == "Clear" || key == "Enter" ? 70 : 60, height: 60)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)

                // يمكنك إزالة هذا الزر إذا أردت أن يقوم زر "Enter" بالتحقق
                /*
                Button("Check Answer") {
                    if let userAnswer = Int(answer) {
                        isCorrectAnswer = userAnswer == question.correctAnswer
                        showFeedback = true
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            showFullScreenFeedback = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showFullScreenFeedback = false
                                showFeedback = false
                            }
                        }
                    } else {
                        print("Please enter a number")
                        // You can show an alert here
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
                */
            }
            .blur(radius: showFullScreenFeedback ? 3 : 0)

            if showFullScreenFeedback {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    Image(systemName: isCorrectAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 200))
                        .foregroundColor(isCorrectAnswer ? .green : .red)
                        .scaleEffect(showFullScreenFeedback ? 1 : 0.5)
                }
            }
        }
    }

    func handleNumberPadInput(_ key: String) {
        switch key {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            answer += key
        case "مسح":
            answer = "" // يمكنك تعديلها لـ `answer = String(answer.dropLast())` إذا كنت تفضل مسح حرف واحد
        case "ادخال":
            if let userAnswer = Int(answer) {
                isCorrectAnswer = userAnswer == question.correctAnswer
                showFeedback = true
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    showFullScreenFeedback = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        showFullScreenFeedback = false
                        showFeedback = false
                    }
                }
            } else {
                print("")
                // يمكنك هنا عرض تنبيه للمستخدم
            }
        default:
            break
        }
    }
}

#Preview {
    Question30()
}
