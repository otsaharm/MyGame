import SwiftUI

struct question40: View {
    @State private var skipCount = 0

    var body: some View {
        UIforAll(skipCount: $skipCount) {
            VStack(spacing: 32) {
                // رقم الصفحة (الدائرة الزرقاء)
                HStack {
                    Image("PAGENUMBER")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .overlay(
                            Text("٤٠")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .padding(.leading, 32)
                    Spacer()
                }
                // ↓↓↓ أضف هذا السطر ↓↓↓
                Spacer(minLength: 60)
                // العنوان
                Text("تذكر هذي الاكواد !")
                    .font(.custom("BalooBhaijaan2-Medium", size: 28))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                // الرقم الكبير
                Text("2489")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 16)
                Spacer()
            }
            .padding(.top, 0)
        }
    }
}

#Preview {
    question40()
}

