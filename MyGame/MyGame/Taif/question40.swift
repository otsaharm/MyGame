import SwiftUI

struct question40: View {
    @State private var skipCount = 0
    @State private var pageNumber: String = "٤٠"
    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            VStack(spacing: 32) {
                
                
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

