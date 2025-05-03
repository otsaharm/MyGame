import SwiftUI

struct Question28: View {
    @State private var arrowOffset: CGFloat = 0
    @State private var showResult: Bool = false
    @State private var isCorrect: Bool? = nil
    @State private var showArrow: Bool = true
    @State private var showQuestionText: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top bar just below dynamic island
                HStack {
                    Image("BUTTON.HOME")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.leading, 24)
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            Image("HEART")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                    }
                    .padding(.trailing, 24)
                }
                .padding(.top, 50)

                // Page number
                HStack {
                    Image("PAGENUMBER")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .overlay(
                            Text("٢٨")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .padding(.leading, 32)
                    Spacer()
                }
                .padding(.top, 160)
                .padding(.bottom, -1000)

                // Main content centered in remaining space
                VStack {
                    HStack(spacing: 16) {
                        ZStack {
                            if showArrow {
                                Image("ARROW")
                                    .resizable()
                                    .frame(width: 100, height: 70)
                                    .rotationEffect(.degrees(arrowOffset < 0 ? -10 : 0))
                                    .offset(x: arrowOffset)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                arrowOffset = value.translation.width
                                            }
                                            .onEnded { value in
                                                let offscreen = geometry.size.width + 100
                                                if value.translation.width < -60 {
                                                    // Dragged left: correct
                                                    withAnimation(.spring()) {
                                                        arrowOffset = -offscreen
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                        withAnimation {
                                                            showArrow = false
                                                            isCorrect = true
                                                            showResult = true
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                            reset()
                                                        }
                                                    }
                                                } else if value.translation.width > 60 {
                                                    // Dragged right: incorrect
                                                    withAnimation(.spring()) {
                                                        arrowOffset = offscreen
                                                        showQuestionText = false
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                        withAnimation {
                                                            showArrow = false
                                                            isCorrect = false
                                                            showResult = true
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                            reset()
                                                        }
                                                    }
                                                } else {
                                                    // Not enough drag, reset
                                                    withAnimation { arrowOffset = 0 }
                                                }
                                            }
                                    )
                            }
                            if showResult, let correct = isCorrect {
                                Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(correct ? .green : .red)
                                    .transition(.scale)
                            }
                        }
                        if showQuestionText {
                            Text("لف السهم لليسار")
                                .font(.system(size: 35, weight: .regular))
                                .multilineTextAlignment(.center)
                                .transition(.opacity)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, -8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
    
    private func reset() {
        withAnimation {
            arrowOffset = 0
            showResult = false
            isCorrect = nil
            showArrow = true
            showQuestionText = true
        }
    }
}

#Preview {
    Question28()
} 
