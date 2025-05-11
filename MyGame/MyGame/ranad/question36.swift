import SwiftUI

struct HiddenNumber {
    let value: Int
    let asset: String
    let position: CGPoint
    let size: CGSize
}

struct Question36: View {
    @State private var code: [Int] = [0, 0, 0, 0]
    let correctCode = [2, 5, 7, 9]
    let arabicDigits = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"]
    @State private var revealed: [Bool] = [false, false, false, false]
    @State private var showSuccess: Bool = false
    let hiddenNumbers: [HiddenNumber] = [
        HiddenNumber(value: 2, asset: "٢", position: CGPoint(x: 90, y: 160), size: CGSize(width: 60, height: 80)),
        HiddenNumber(value: 5, asset: "٥", position: CGPoint(x: 300, y: 250), size: CGSize(width: 40, height: 45)),
        HiddenNumber(value: 7, asset: "٧", position: CGPoint(x: 60, y: 600), size: CGSize(width: 30, height: 35)),
        HiddenNumber(value: 9, asset: "٩", position: CGPoint(x: 350, y: 700), size: CGSize(width: 20, height: 25))
    ]
    let tapRadius: CGFloat = 40
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            // Hidden numbers (only show if revealed)
            ForEach(0..<4) { i in
                if revealed[i] {
                    Image(hiddenNumbers[i].asset)
                        .resizable()
                        .frame(width: hiddenNumbers[i].size.width, height: hiddenNumbers[i].size.height)
                        .position(hiddenNumbers[i].position)
                        .transition(.scale)
                }
            }
            VStack(spacing: 0) {
                Spacer().frame(height: 150)
                // Question
                HStack(spacing: 0) {
                    Text("الصندوق")
                        .font(.system(size: 28, weight: .regular))
                        .foregroundColor(.black)
                    Text("افتح")
                        .font(.system(size: 80, weight: .regular))
                        .foregroundColor(.black)

                }
                Spacer()
                // Safe box
                ZStack {
                    Image("SAFEBOX")
                        .resizable()
                        .frame(width: 423, height: 282)
                    // Code display area (tunable position)
                    HStack(spacing: 20) {
                        ForEach(0..<4) { i in
                            Text(arabicDigits[code[i]])
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                    .position(x: 212, y: 180) // Tune these values to match the screen area
                    // Success checkmark
                    if showSuccess {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.green)
                            .position(x: 212, y: 180)
                    }
                }
                .offset(y: -60)
                Spacer().frame(height: 32)
                // Number selectors with custom up/down buttons (always available)
                HStack(spacing: 24) {
                    ForEach(0..<4) { i in
                        VStack(spacing: 8) {
                            Button(action: {
                                code[i] = (code[i] + 1) % 10
                                checkWin()
                            }) {
                                Image("UP.ARROW")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                            }
                            Text(arabicDigits[code[i]])
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                            Button(action: {
                                code[i] = (code[i] + 9) % 10
                                checkWin()
                            }) {
                                Image("DOWN.ARROW")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                            }
                        }
                    }
                }
                .offset(y: -90)
                Spacer()
            }
            // Add tap gesture to the ZStack to reveal numbers when tapped
            .contentShape(Rectangle())
            .onTapGesture { location in
                for i in 0..<hiddenNumbers.count {
                    if !revealed[i] {
                        let hidden = hiddenNumbers[i]
                        let dx = location.x - hidden.position.x
                        let dy = location.y - hidden.position.y
                        if dx * dx + dy * dy < tapRadius * tapRadius {
                            revealed[i] = true
                        }
                    }
                }
            }
        }
    }
    
    func checkWin() {
        if code == correctCode {
            showSuccess = true
        } else {
            showSuccess = false
        }
    }
}

#Preview {
    Question36()
} 
