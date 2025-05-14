import SwiftUI

struct Question31: View {
    @State private var skipCount = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false

    @State private var offset = CGSize.zero
    @State private var isDroppedOverAnimals = false
    @State private var showCheckmark = false
    @State private var soundPlayed = false // لمنع تكرار الصوت

    let question = Question(
        id: 31,
        type: "multiple-choice",
        question: "وين الحيوانات اللي فوق السؤال ؟",
        options: ["", " ", "", ""],
        correctAnswer: 0
    )

    var body: some View {
        return UIforAll(skipCount: $skipCount) {
            ZStack {
                VStack(spacing: 100) {
                    HStack(spacing: 4) {
                        Text("السؤال")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .offset(offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        self.offset = value.translation
                                    }
                                    .onEnded { value in
                                        if value.location.y > 150 && value.location.y < 350 {
                                            isDroppedOverAnimals = true
                                            showCheckmark = true
                                            if !soundPlayed {
                                                playSound(for: true)
                                                soundPlayed = true
                                            }
                                        } else {
                                            isDroppedOverAnimals = false
                                            showCheckmark = false
                                            soundPlayed = false
                                        }
                                    }
                            )
                            .foregroundColor(isDroppedOverAnimals ? .green : .black)

                        Text("وين الحيوانات اللي فوق")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)

                    HStack(spacing: 15) {
                        Image("animal4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)

                        Image("animal2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)

                        Image("animal3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                    }
                    .padding(.top, 20)

                    if showCheckmark {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                            .padding(.top, 20)
                    }
                }
            }
        }
    }
}

#Preview {
    Question31()
}
