import SwiftUI
import AVFoundation

struct Question40: View {
    @State private var skipCount = 0
    let numbers = [600, 250, -459, -3, 55]
    
    @State private var selectedOrder: [Int] = []
    @State private var isCorrect = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var pageNumber: String = "٤٠"
    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            VStack {
                Text("رتبهم من الأقل إلى الأعلى")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)

                VStack(spacing: 16) {
                    ForEach(Array(numbers.reversed()), id: \.self) { number in
                        let selectionIndex = selectedOrder.firstIndex(of: number)
                        
                        ZStack(alignment: .topTrailing) {
                            Text("\(number)")
                                .frame(width: 100, height: 50)
                                .cornerRadius(12)
                                .font(.title3)
                            
                            if let index = selectionIndex {
                                Circle()
                                    .fill(Color.blue.opacity(0.8))
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    )
                                    .offset(x: 12, y: -12)
                            }
                        }
                        .onTapGesture {
                            handleTap(number: number)
                        }
                        .disabled(selectionIndex != nil || isCorrect)
                    }
                }
                .padding()
                
                Button(action: {
                    checkFinalOrder()
                }) {
                    Text("تحقق من الإجابة")
                        .font(.headline)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .disabled(selectedOrder.count < numbers.count)
            }
        }
    }

    func handleTap(number: Int) {
        guard !selectedOrder.contains(number) else { return }
        selectedOrder.append(number)
        
        // تحقق إذا كانت جميع الأرقام قد تم اختيارها
        if selectedOrder.count == numbers.count {
            isCorrect = true
        }
    }

    func checkFinalOrder() {
        // التحقق من الترتيب النهائي
        let isOrderCorrect = selectedOrder == numbers.sorted()
        if isOrderCorrect {
            playSound(isCorrect: true)
            print("الإجابة صحيحة!")
        } else {
            playSound(isCorrect: false)
            print("الإجابة خاطئة!")
        }
    }

    func playSound(isCorrect: Bool) {
        let soundName = isCorrect ? "success" : "failure"
        if let url = Bundle.main.url(forResource: soundName, withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("خطأ في تشغيل الصوت: \(error)")
            }
        }
    }
}

struct question40_Previews: PreviewProvider {
    static var previews: some View {
        Question40()
    }
}
