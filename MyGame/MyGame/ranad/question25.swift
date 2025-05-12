import SwiftUI
import UniformTypeIdentifiers

struct Question25: View {
    @State private var skipCount: Int = 0
    // Adjustable initial positions as fractions of width and height
    @State private var initialPositions: [CGPoint] = [
        CGPoint(x: 0.25, y: 0.15), // ROCK
        CGPoint(x: 0.5, y: 0.45),  // PAPER
        CGPoint(x: 0.75, y: 0.2)  // SCISSORS
    ]

    @State private var rockOffset = CGSize.zero
    @State private var paperOffset = CGSize.zero
    @State private var scissorsOffset = CGSize.zero
    @State private var rockGone = false
    @State private var paperGone = false
    @State private var showCheck = false

    let imageSize: CGFloat = 130

    func center(for geo: GeometryProxy, base: CGPoint, offset: CGSize) -> CGPoint {
        CGPoint(
            x: geo.size.width * base.x + offset.width,
            y: geo.size.height * base.y + offset.height
        )
    }

    func isOverlapping(_ a: CGPoint, _ b: CGPoint, threshold: CGFloat = 60) -> Bool {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return dx * dx + dy * dy < threshold * threshold
    }

    var body: some View {
        UIforAll(skipCount: $skipCount) {
            GeometryReader { geo in
                VStack(spacing: 24) {
                    Text("فوّز المقص")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top, 140)
                    Spacer(minLength:0)
                    ZStack {
                        // ROCK
                        if !rockGone {
                            Image("ROCK")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                                .position(x: geo.size.width * initialPositions[0].x + rockOffset.width,
                                          y: geo.size.height * initialPositions[0].y + rockOffset.height)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            rockOffset = value.translation
                                        }
                                        .onEnded { _ in }
                                )
                                .zIndex(1)
                        }
                        // PAPER
                        if !paperGone {
                            Image("PAPER")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                                .position(x: geo.size.width * initialPositions[1].x + paperOffset.width,
                                          y: geo.size.height * initialPositions[1].y + paperOffset.height)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            paperOffset = value.translation
                                        }
                                        .onEnded { _ in
                                            let paperCenter = center(for: geo, base: initialPositions[1], offset: paperOffset)
                                            let rockCenter = center(for: geo, base: initialPositions[0], offset: rockOffset)
                                            if !rockGone && isOverlapping(paperCenter, rockCenter) {
                                                rockGone = true
                                            }
                                            paperOffset = .zero
                                        }
                                )
                                .zIndex(2)
                        }
                        // SCISSORS
                        Image("SCISSORS")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                            .position(x: geo.size.width * initialPositions[2].x + scissorsOffset.width,
                                      y: geo.size.height * initialPositions[2].y + scissorsOffset.height)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        scissorsOffset = value.translation
                                    }
                                    .onEnded { _ in
                                        let scissorsCenter = center(for: geo, base: initialPositions[2], offset: scissorsOffset)
                                        let paperCenter = center(for: geo, base: initialPositions[1], offset: paperOffset)
                                        if !paperGone && isOverlapping(scissorsCenter, paperCenter) && rockGone {
                                            paperGone = true
                                            showCheck = true
                                        }
                                        scissorsOffset = .zero
                                    }
                            )
                            .zIndex(3)
                    }
                    Spacer()
                    if showCheck {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.green)
                            .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }
}

#Preview {
    Question25()
} 
