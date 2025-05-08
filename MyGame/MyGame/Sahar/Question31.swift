import SwiftUI

struct Question31: View {
    @State private var selectedAnswer: Int? = nil
    @State private var showFeedback: Bool = false
    @State private var showFullScreenFeedback: Bool = false

    let question = Question(
        id: 31,
        type: "multiple-choice",
        question: "وين الصقر  اللي فوق السؤال ؟؟",
        options: ["القمر", " القمر", "الشمس", "الطيارة"],
        correctAnswer: 0
    )

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(question.question)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    ForEach(0..<3, id: \.self) { index in // Displaying 3 images
                        Button(action: {
                            selectedAnswer = index
                            showFeedback = true
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                showFullScreenFeedback = true
                            }
                            // Hide the full screen feedback after 1.5 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeOut(duration: 0.3)) {
                                    showFullScreenFeedback = false
                                    // Reset the selection when popup disappears
                                    selectedAnswer = nil
                                    showFeedback = false
                                }
                            }
                        }) {
                            ZStack {
                                Image(getImageName(for: index)) // Function to get image name
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 100) // Adjust max height as needed
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 0) // Removed blue border
                                    )

                                if showFeedback && selectedAnswer == index {
                                    Image(systemName: index == question.correctAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .disabled(selectedAnswer != nil) // Disable buttons after selection
                    }
                    // Add an empty view if there are fewer than 4 options to keep the grid layout consistent
                    if question.options.count < 4 {
                        ForEach(question.options.count..<4, id: \.self) { _ in
                            Color.clear // Placeholder for empty grid cells
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

    func getImageName(for index: Int) -> String {
        // Replace these with the actual names of your image assets
        switch index {
        case 0:
            return "men"
        case 1:
            return "men"
        case 2:
            return "men"
        default:
            return "airplane" // Fallback image
        }
    }
}

struct Question6: Identifiable {
    let id: Int
    let type: String
    let question: String
    let options: [String]
    let correctAnswer: Int
}

#Preview {
    Question31()
}
