import SwiftUI

struct Question10: View {
    // تقسيم الرسالة إلى ثلاثة صفوف
    let row1: [Character] = Array("اضغط زر") // indices 0-6
    let row2: [Character] = Array("البيت")   // indices 7-11
    let row3: [Character] = Array("للفوز")   // indices 12-16
    let colors: [Color]
    let colorReveals: [[Int]]
    @State private var pressingColor: Int? = nil
    @State private var skipCount: Int = 0
    @State private var pageNumber: String = "١٠"
    var onNext: () -> Void

    init(onNext: @escaping () -> Void = {}) {
        // توزيع الحروف على الألوان
        self.colorReveals = [
            [0, 11, 5],                // برتقالي
            [1, 7, 15, 4],             // أصفر
            [3, 16, 8, 18],            // بنفسجي
            [9, 2, 11],                // أزرق
            [12, 6, 8],                // أخضر
            [10, 13, 14, 17]           // أحمر
        ]
        self.colors = [
            Color(red: 0.98, green: 0.68, blue: 0.33), // برتقالي
            Color(red: 0.99, green: 0.89, blue: 0.38), // أصفر
            Color(red: 0.38, green: 0.29, blue: 0.87), // بنفسجي
            Color(red: 0.47, green: 0.69, blue: 1.00), // أزرق
            Color(red: 0.44, green: 0.82, blue: 0.51), // أخضر
            Color(red: 0.98, green: 0.47, blue: 0.44)  // أحمر
        ]
        self.onNext = onNext
    }

    var body: some View {
        UIforAll(
            skipCount: $skipCount,
            pageNumber: $pageNumber,
            onHomeOverride: {
                onNext() // فقط في السؤال العاشر: عند الضغط على زر الهوم ينتقل للسؤال 11
            }
        ) {
            GeometryReader { geometry in
                VStack {
                    Spacer(minLength: geometry.size.height * 0.10)
                    VStack(spacing: 12) {
                        rowView(row: row1, offset: 0)
                        rowView(row: row2, offset: row1.count)
                        rowView(row: row3, offset: row1.count + row2.count)
                    }
                    .padding(.horizontal, 8)
                    .environment(\.layoutDirection, .rightToLeft)
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<6) { idx in
                            Rectangle()
                                .fill(colors[idx])
                                .frame(width: 50, height: 180)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { _ in
                                            pressingColor = idx
                                        }
                                        .onEnded { _ in
                                            pressingColor = nil
                                        }
                                )
                        }
                    }
                    .padding(.bottom, geometry.size.height * 0.08)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }

    // عرض صف من الحروف
    func rowView(row: [Character], offset: Int) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<row.count, id: \.self) { i in
                let globalIndex = offset + i
                if let colorIdx = pressingColor, colorReveals[colorIdx].contains(globalIndex) {
                    Text(String(row[i]))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .frame(width: 32, height: 40)
                        .foregroundColor(colors[colorIdx])
                } else {
                    Text(" ")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .frame(width: 32, height: 40)
                }
            }
        }
    }
}

#Preview {
    Question10(onNext: {})
}
