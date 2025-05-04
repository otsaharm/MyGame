//
//  Question9.swift
//  MyGame
//
//  Created by Sahar Otiyn on 29/10/1446 AH.
//

import SwiftUI

struct Question9: View {
    @State private var skipCount = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false
    
    let question = Question(
        id: 9,
        type: "multiple-choice",
        question: "",
        options: ["سعف", "جذع", "رطب", "جذور"],
        correctAnswer: 2
    )
    
    var body: some View {
//        UIMult(skipCont: $skipCount)
//                .ignoresSafeArea() // يضمن تغطية الصفحة كاملة

        ZStack {
            VStack(spacing: 2) {
                // الصورة
                Image("root")
                            .resizable()
                            .frame(width: 300, height: 120)
                            .padding(.top, -20)
                        Text("النخلة")
                            .font(.system(size:60))
                            .fontWeight(.bold)
                            .padding(.top, -100)
                            .padding(.leading, 150)
                Text(question.question)
                    .font(.title2)
                    .multilineTextAlignment(.center)

                // خيارات الإجابة
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
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
            .blur(radius: showFullScreenFeedback ? 3 : 0)
            
            if showFullScreenFeedback, let selected = selectedAnswer {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    Image(systemName: selected == question.correctAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 200))
                        .foregroundColor(selected == question.correctAnswer ? .green : .red)
                        .scaleEffect(showFullScreenFeedback ? 1 : 0.5)
                }
            }
        }
    }
}

#Preview {
    Question9()
}
