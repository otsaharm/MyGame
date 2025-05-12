import SwiftUI

struct Question49: View {
    let klegaCount = 7
    let radius: CGFloat = 110
    let klegaSize: CGFloat = 80
    let handSize: CGFloat = 75
    let centerY: CGFloat = 380
    let centerX: CGFloat = 200
    
    @State private var handIndex: Int = 0
    @State private var isFlashing: Bool = false
    @State private var flashIndex: Int? = nil
    @State private var canTap: Bool = false
    @State private var showSuccess: Bool = false
    @State private var cycles: Int = 0
    @State private var timer: Timer? = nil
    @State private var skipCount: Int = 0
    
    var body: some View {
        UIforAll(skipCount: $skipCount) {
            ZStack {
                // Question text
                Text("اويلاو وين الكليجه اللي نبيها")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .position(x: centerX , y: 120)
                // Klega circle
                ForEach(0..<klegaCount, id: \.self) { i in
                    let angle = Double(i) / Double(klegaCount) * 2 * Double.pi - Double.pi/2
                    let x = centerX + radius * cos(angle)
                let y = centerY + radius * sin(angle)
                    ZStack {
                        Image("KLEGA")
                            .resizable()
                            .frame(width: klegaSize, height: klegaSize)
                            .background(
                                (isFlashing && flashIndex == i) ? Color.yellow.opacity(0.6) : Color.clear
                            )
                            .clipShape(Circle())
                            .onTapGesture {
                                if canTap && flashIndex == i {
                                    showSuccess = true
                                    canTap = false
                                }
                            }
                        if showSuccess && flashIndex == i {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.green)
                        }
                    }
                    .position(x: x, y: y)
                }
                // Animated hand
                if !showSuccess {
                    let angle = Double(handIndex) / Double(klegaCount) * 2 * Double.pi - Double.pi/2
                    let handX = centerX + (radius + 80) * cos(angle)
                    let handY = centerY + (radius + 80) * sin(angle)
                    Image("HAND")
                        .resizable()
                        .frame(width: handSize, height: handSize)
                        .scaleEffect(x: -1, y: 1)
                        .rotationEffect(.radians(angle - .pi/2))
                        .position(x: handX, y: handY)
                        .animation(.easeInOut(duration: 0.18), value: handIndex)
                }
            }
            .onAppear { startHandAnimation() }
            .onDisappear { timer?.invalidate() }
        }
    }
    
    func startHandAnimation() {
        timer?.invalidate()
        handIndex = 0
        cycles = 0
        isFlashing = false
        flashIndex = nil
        canTap = false
        showSuccess = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.20, repeats: true) { _ in
            if isFlashing {
                // End flash
                isFlashing = false
                canTap = true
                timer?.invalidate()
            } else {
                handIndex = (handIndex + 1) % klegaCount
                if handIndex == 0 {
                    cycles += 1
                }
                if cycles >= 2 && handIndex == 0 && flashIndex == nil {
                    // Pick a random klega to flash
                    let random = Int.random(in: 0..<klegaCount)
                    flashIndex = random
                    isFlashing = true
                    // Flash for 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        isFlashing = false
                        canTap = true
                    }
                }
            }
        }
    }
}

#Preview {
    Question49()
} 
