//
//  Question24.swift
//  MyGame
//
//  Created by Sahar Otiyn on 30/10/1446 AH.
//


import SwiftUI

struct Question24: View {
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    @State private var isAnswerPressed = false // حالة خاصة بضغط كلمة "الجواب"

    let question = Question(
        id: 24,
        type: "multiple-choice",
        question: "25-1=?",
        options: ["فرس النهر", "24.931", "20", "18"],
        correctAnswer: 6 // الجواب هو الخيار الثالث (الجواب)
    )

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // عرض السؤال مع كلمة "الجواب" القابلة للنقر
                HStack {
              // اللون الأساسي للسؤال
                    Circle()
                        .stroke(Color.black, lineWidth: 3)
                        .frame(width: 35, height: 30)
                        .position(x: 40, y: 60)

                    Text("٢٤") // كلمة الجواب
                        .font(.title2)
                        .foregroundColor(.black)
                        .position(x: -110, y: 60)
                        .foregroundColor(isAnswerPressed ? .green : .black) // تغيير اللون إلى أخضر عند الضغط
                        .onTapGesture {
                            // عند النقر على كلمة "الجواب"
                            if selectedAnswer == nil {
                                isAnswerPressed = true
                                selectedAnswer = question.correctAnswer // نعتبر النقر على "الجواب" اختيارًا صحيحًا
                                showFeedback = true
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    showFullScreenFeedback = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(.easeOut(duration: 0.3)) {
                                        showFullScreenFeedback = false
                                        selectedAnswer = nil
                                        showFeedback = false
                                        isAnswerPressed = false
                                    }
                                }
                            }
                        }
                    Text("25-1=?")
                        .font(.title2)
                        .foregroundColor(.black)
                        
                }

                // عرض باقي الخيارات
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<question.options.count, id: \.self) { index in
                        Button(action: {
                            selectedAnswer = index
                            showFeedback = true
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                showFullScreenFeedback = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    showFullScreenFeedback = false
                                    selectedAnswer = nil
                                    showFeedback = false
                                }
                            }
                        }) {
                            ZStack {
                                Text(question.options[index])
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        selectedAnswer == index ?
                                            (index == question.correctAnswer ? Color.green : Color.red) :
                                            Color.white
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 2)
                                    )

                                if showFeedback && selectedAnswer == index {
                                    Image(systemName: index == question.correctAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .padding()
            .blur(radius: showFullScreenFeedback ? 3 : 0)

            // عرض الفيدباك بملء الشاشة
            if showFullScreenFeedback, let selected = selectedAnswer {
                FullScreenFeedbackView(isCorrect: selected == question.correctAnswer)
            }
        }
    }
}

// إنشاء View منفصل للفيدباك بملء الشاشة لتنظيم الكود
struct FullScreenFeedbackVie: View {
    let isCorrect: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 200))
                .foregroundColor(isCorrect ? .green : .red)
                .scaleEffect(1.0) // تم تعديلها لتكون 1 مباشرة
        }
    }
}

#Preview {
    Question24()
}
