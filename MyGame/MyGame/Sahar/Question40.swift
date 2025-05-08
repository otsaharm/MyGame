import SwiftUI

struct StaticVerticalNumberOrderGame: View {
    let numbers = [-7, 3, -10, 0, 8].shuffled()
    var sortedNumbers: [Int] {
        numbers.sorted()
    }

    @State private var selectedOrder: [Int] = []
    @State private var isCorrect = false

    var body: some View {
        VStack {
            Text("اضغط على الأرقام من الأصغر إلى الأكبر")
                .font(.headline)
                .padding()

            VStack(spacing: 16) {
                ForEach(numbers.indices, id: \.self) { index in
                    let number = numbers[index]
                    let selectionIndex = selectedOrder.firstIndex(of: number)

                    ZStack(alignment: .topTrailing) {
                        Text("\(number)")
                            .frame(width: 100, height: 50)
                            .background(Color.gray.opacity(0.3))
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

            // ظهور علامة الصح عند الإجابة الصحيحة
            if isCorrect {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    Image(systemName: "checkmark.circle.fill") // علامة صح كبيرة
                        .font(.system(size: 200))
                        .foregroundColor(.green)
                        .scaleEffect(1) // تأثير تكبير للعلامة
                        .transition(.scale) // تأثير تكبير
                }
            }

            Spacer()
        }
        .padding()
        .animation(.easeInOut, value: isCorrect) // إضافة حركة سلسة للعلامة
    }

    func handleTap(number: Int) {
        guard !selectedOrder.contains(number) else { return }

        let nextExpectedNumber = sortedNumbers[selectedOrder.count]
        if number == nextExpectedNumber {
            selectedOrder.append(number)
            if selectedOrder.count == sortedNumbers.count {
                isCorrect = true
            }
        }
    }
}

struct StaticVerticalNumberOrderGame_Previews: PreviewProvider {
    static var previews: some View {
        StaticVerticalNumberOrderGame()
    }
}
