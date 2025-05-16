import SwiftUI

struct Question45: View {
    @State private var selected: Int? = nil
    @State private var isCorrect: Bool? = nil
    let answers = [
        "خشيم النوم", // Top left
        "وادي بقر",   // Top right
        "مطرفه",      // Bottom left (correct)
        "محير الترمس" // Bottom right
    ]
    let correctIndex = 2
    // Adjustable positions for each answer (relative to geometry size)
    @State private var positions: [CGPoint] = [
        CGPoint(x: 0.28, y: 0.54), // Top left
        CGPoint(x: 0.72, y: 0.54), // Top right
        CGPoint(x: 0.28, y: 0.676), // Bottom left
        CGPoint(x: 0.725, y: 0.676)  // Bottom right
    ]
    // Adjustable background offsets
    let backgroundOffsetX: CGFloat = -1
    let backgroundOffsetY: CGFloat = 50 // Move background 30 points down
    var onNext: () -> Void = {} // متغير الانتقال
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("Q45.BACKGROUND")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(x: backgroundOffsetX, y: backgroundOffsetY)
                    .ignoresSafeArea()
                // Individually positioned answer texts
                ForEach(0..<4) { i in
                    answerText(index: i, fontSize: geo.size.width * 0.09)
                        .position(x: geo.size.width * positions[i].x, y: geo.size.height * positions[i].y)
                        .onTapGesture {
                            if selected == nil {
                                selected = i
                                if i == correctIndex {
                                    // الانتقال التلقائي بعد نصف ثانية
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                        onNext()
                                    }
                                }
                            }
                        }
                }
                // Show checkmark if correct answer is selected
                if selected == correctIndex {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.green)
                        .position(x: geo.size.width * positions[correctIndex].x, y: geo.size.height * positions[correctIndex].y - 40)
                }
            }
        }
    }
    
    @ViewBuilder
    func answerText(index: Int, fontSize: CGFloat) -> some View {
        Text(answers[index])
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    Question45()
} 
 