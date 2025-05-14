import SwiftUI

struct Question48: View {
    @State private var skipCount = 0
    @State private var skirtPosition = CGSize(width: 150, height: 250)
    private let originalPosition = CGSize(width: 150, height: 250)
    @State private var showCheckmark = false
    @State private var soundPlayed = false // علشان ما يتكرر الصوت كل مرة

    var body: some View {
        UIforAll(skipCount: $skipCount) {
            VStack {
                Text("ساعد الولد يروح الحمام")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, -50)
                    .padding(.top, 40)

                ZStack {
                    Image("door")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)

                    Image("rectan")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 10)
                        .padding(.top, -121)
                        .padding(.horizontal, -69)
                        .position(x: skirtPosition.width, y: skirtPosition.height)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    self.skirtPosition = CGSize(
                                        width: originalPosition.width + value.translation.width,
                                        height: originalPosition.height + value.translation.height
                                    )

                                    let distance = hypot(
                                        skirtPosition.width - originalPosition.width,
                                        skirtPosition.height - originalPosition.height
                                    )

                                    if distance > 50 {
                                        withAnimation {
                                            showCheckmark = true
                                        }
                                        if !soundPlayed {
                                            playSound(for: true)
                                            soundPlayed = true
                                        }
                                    } else {
                                        withAnimation {
                                            showCheckmark = false
                                        }
                                        soundPlayed = false
                                    }
                                }
                        )

                    if showCheckmark {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                            .position(x: 200, y: 100)
                            .transition(.scale)
                    }
                }
            }
        }
    }
}

struct Question48_Previews: PreviewProvider {
    static var previews: some View {
        Question48()
    }
}
