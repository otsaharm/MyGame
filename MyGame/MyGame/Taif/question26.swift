

import SwiftUI

struct question26: View {
    @State private var isDropped = false
    @State private var skipCount = 0
    @State private var offset = CGSize.zero
    @State private var pageNumber: String = "٢٦"
    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            VStack(spacing: 32) {
                Spacer().frame(height: 40)

                // الدائرة الزرقاء (٢٦) قابلة للسحب
                HStack {
                    if !isDropped {
                        Image("PAGENUMBER")
                            .resizable()
                            .frame(width: 42, height: 42)
                            .overlay(
                                Text("٢٦")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .offset(offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        self.offset = value.translation
                                    }
                                    .onEnded { value in
                                        // تحقق إذا تم الإسقاط فوق الرقم ٣٣ (حسب إحداثيات الشاشة)
                                        if value.location.y > 180 && value.location.y < 320 &&
                                            value.location.x > 120 && value.location.x < 260 {
                                            isDropped = true
                                        } else {
                                            offset = .zero
                                        }
                                    }
                            )
                            .padding(.leading, 32)
                    }
                    Spacer()
                }
                .padding(.top, 8)

                // نص السؤال
                Text("كيف بتحل هذي المعادلة؟")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)

                // المعادلة مع الرقم القابل للإسقاط
                HStack {
                    Spacer()
                    Text("١٠٠٠ +")
                        .font(.custom("BalooBhaijaan2-Medium", size: 32))
                        .foregroundColor(.black)
                    // الرقم ٣٣ القابل للإسقاط عليه (بدون مربع أخضر)
                    Text(isDropped ? "٢٦٣٣" : "٣٣")
                        .font(.custom("BalooBhaijaan2-Medium", size: 32))
                        .foregroundColor(.black)
                        .padding(8)
                    Text("= ١٢٦٣٣")
                        .font(.custom("BalooBhaijaan2-Medium", size: 32))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 40)

                Spacer()
            }
        }
    }
}

#Preview {
    question26()
}

