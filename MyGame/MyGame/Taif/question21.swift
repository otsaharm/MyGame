






import SwiftUI

struct question21: View {
    @State private var skipCount = 0
    @State private var droppedIndex: Int? = nil
    @State private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var camelFrames: [CGRect] = Array(repeating: .zero, count: 4)
    @State private var pageNumber: String = "٢١"
    let correctIndex = 2

    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            VStack(spacing: 0) {
               

                // رقم السؤال في الدائرة الزرقاء
               

                // نص السؤال مع كلمة "الوضحى" في النهاية وقابلة للسحب والتحريك
                HStack(spacing: 8) {
                    Text("من بين المجاهيم وين")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    DraggableWord(
                        dragOffset: $dragOffset,
                        isDragging: $isDragging,
                        droppedIndex: $droppedIndex,
                        camelFrames: $camelFrames
                    )
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)

                // شبكة الجمال (2x2) بحجم أكبر
                CamelsGrid(
                    droppedIndex: $droppedIndex,
                    camelFrames: $camelFrames,
                    correctIndex: correctIndex
                )
                .frame(height: 400)

                Spacer()
            }
        }
    }
}

// شبكة الجمال مع حفظ مواقعها
struct CamelsGrid: View {
    @Binding var droppedIndex: Int?
    @Binding var camelFrames: [CGRect]
    let correctIndex: Int

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 32) {
                HStack(spacing: 32) {
                    camelView(index: 0, geo: geo)
                    camelView(index: 1, geo: geo)
                }
                HStack(spacing: 32) {
                    camelView(index: 2, geo: geo)
                    camelView(index: 3, geo: geo)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    func camelView(index: Int, geo: GeometryProxy) -> some View {
        GeometryReader { camelGeo in
            Image(droppedIndex == index && index == correctIndex ? "whitecamel" : "camel")
                .resizable()
                .frame(width: 160, height: 160)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(droppedIndex == index ? Color.green : Color.clear, lineWidth: 3)
                )
                .onAppear {
                    // حفظ موقع الجمل في مصفوفة camelFrames
                    DispatchQueue.main.async {
                        camelFrames[index] = camelGeo.frame(in: .global)
                    }
                }
                .onChange(of: camelGeo.frame(in: .global)) { newFrame in
                    DispatchQueue.main.async {
                        camelFrames[index] = newFrame
                    }
                }
        }
        .frame(width: 160, height: 160)
    }
}

// كلمة "الوضحى" القابلة للسحب والتحريك
struct DraggableWord: View {
    @Binding var dragOffset: CGSize
    @Binding var isDragging: Bool
    @Binding var droppedIndex: Int?
    @Binding var camelFrames: [CGRect]

    var body: some View {
        Text("الوضحى")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isDragging ? Color.blue.opacity(0.2) : Color.clear)
            )
            .offset(dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                        isDragging = true
                    }
                    .onEnded { value in
                        isDragging = false
                        // حساب مركز الكلمة بعد السحب
                        let wordCenter = CGPoint(
                            x: UIScreen.main.bounds.width / 2 + dragOffset.width,
                            y: 180 + dragOffset.height // 180 تقريبية حسب مكان الكلمة
                        )
                        for (i, frame) in camelFrames.enumerated() {
                            if frame.contains(wordCenter) {
                                droppedIndex = i
                            }
                        }
                        dragOffset = .zero
                    }
            )
    }
}

#Preview {
    question21()
}
