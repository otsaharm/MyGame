import SwiftUI

struct question6: View {
    @State private var offset1: CGSize = .zero
    @State private var offset2: CGSize = .zero
    @State private var offset3: CGSize = .zero

    @State private var cupCount: Int = 0
    @State private var showResult: String? = nil
    @State private var skipCount: Int = 0

    var body: some View {
        UIforAll(skipCount: $skipCount) {
            VStack(spacing: 20) {
                Spacer(minLength: 40)

                Text("كم عدد الفناجين؟")
                    .font(.title2)

                Spacer()

                ZStack {
                    // فناجين ثابتة
                    Image("cup6")
                        .resizable()
                        .frame(width: 119, height: 119)
                        .offset(x: -80, y: -80)

                    Image("cup6")
                        .resizable()
                        .frame(width: 119, height: 119)
                        .offset(x: 80, y: -80)

                    Image("cup6")
                        .resizable()
                        .frame(width: 119, height: 119)
                        .offset(y: 40)

                    // فناجين قابلة للسحب
                    Image("cup6")
                        .resizable()
                        .frame(width: 119, height: 119)
                        .offset(offset1)
                        .offset(x: -80, y: -80)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset1 = gesture.translation
                                }
                        )

                    Image("cup6")
                        .resizable()
                        .frame(width: 119, height: 119)
                        .offset(offset2)
                        .offset(x: 80, y: -80)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset2 = gesture.translation
                                }
                        )

                    Image("cup6")
                        .resizable()
                        .frame(width: 119, height: 119)
                        .offset(offset3)
                        .offset(y: 40)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset3 = gesture.translation
                                }
                        )
                }

                Spacer()

                // أزرار العدد
                HStack(spacing: 20) {
                    Button(action: {
                        cupCount += 1
                    }) {
                        Image("plus6")
                            .resizable()
                            .frame(width: 42, height: 40)
                    }

                    Text("\(cupCount)")
                        .font(.largeTitle)

                    Button(action: {
                        if cupCount > 0 {
                            cupCount -= 1
                        }
                    }) {
                        Image("minus6")
                            .resizable()
                            .frame(width: 42, height: 40)
                    }
                }

                // زر التأكيد
                Button(action: {
                    if cupCount == 6 {
                        showResult = "إجابة صحيحة"
                    } else {
                        showResult = "إجابة خاطئة ❌"
                    }
                }) {
                    Image("ok6")
                        .resizable()
                        .frame(width: 100, height: 40)
                }

                // عرض النتيجة
                if let result = showResult {
                    Text(result)
                        .font(.title2)
                        .foregroundColor(result.contains("صح") ? .green : .red)
                        .padding()
                }

                Spacer()
            }
        }
    }
}

#Preview {
    question6()
}

