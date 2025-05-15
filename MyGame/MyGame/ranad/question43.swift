import SwiftUI

struct Question43: View {
    @State private var countdown: Int = 6
    @State private var bombScale: CGFloat = 1.0
    @State private var bombShake: CGFloat = 0.0
    @State private var numberScale: CGFloat = 1.0
    @State private var timer: Timer? = nil
    @State private var pageNumber: String = "٤٣"
    @State private var skipCount: Int = 0
    // Arabic numerals for 6 to 1
    let arabicNumbers = [6: "٦", 5: "٥", 4: "٤", 3: "٣", 2: "٢", 1: "١"]
    
    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            ZStack {
                VStack(spacing: 0) {
                    Spacer().frame(height: 120) // Space from top
                    // Question
                    Text("فكر بسرعه !!!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    Spacer().frame(height: 40) // Space between question and bomb
                    // Bomb and countdown number
                    ZStack {
                        Image("BOMB")
                            .resizable()
                            .frame(width: 350, height: 350)
                            .scaleEffect(bombScale)
                            .offset(x: 30) // Move bomb to the right
                            .animation(.easeInOut(duration: 0.15), value: bombScale)
                            .animation(.easeInOut(duration: 0.08), value: bombShake)
                        if let num = arabicNumbers[countdown] {
                            Text(num)
                                .font(.system(size: 90, weight: .bold))                            .foregroundColor(.red)
                                .scaleEffect(numberScale)
                                .frame(width: 80, height: 80, alignment: .center)
                                .offset(y: 45)
                                .animation(.easeInOut(duration: 0.15), value: numberScale)
                        }
                    }
                    .frame(width: 350, height: 350)
                    Spacer()
                }
                // Arrow and hint at bottom left
                if countdown <= 4 {
                    VStack {
                        Spacer()
                        HStack {
                            ZStack {
                                Image("ARROW")
                                    .resizable()
                                    .frame(width: 70, height: 50)
                                Text("النحشة")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .offset(x: 1) // adjust as needed to center in arrow
                            }
                            Spacer()
                        }
                        .padding(.leading, 16)
                        .padding(.bottom, 60)
                    }
                    .transition(.opacity)
                }
            }
            .onAppear {
                startCountdown()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }
    
    func startCountdown() {
        timer?.invalidate()
        countdown = 6
        bombScale = 1.0
        bombShake = 0.0
        numberScale = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.15)) {
                bombScale = 1.15
                numberScale = 1.2
            }
            withAnimation(.easeInOut(duration: 0.08).delay(0.15)) {
                bombShake = -15
            }
            withAnimation(.easeInOut(duration: 0.08).delay(0.23)) {
                bombShake = 15
            }
            withAnimation(.easeInOut(duration: 0.08).delay(0.31)) {
                bombShake = 0
                bombScale = 1.0
                numberScale = 1.0
            }
            if countdown > 1 {
                countdown -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
}

#Preview {
    Question43()
} 
