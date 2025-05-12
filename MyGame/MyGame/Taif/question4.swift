import SwiftUI

struct question4: View {
    @State private var skipCount = 0
    @State private var showColors = true // ظهور الألوان في البداية
    @State private var selectedAnswer: Int? = nil

    let correctIndex = 3
    let questionText = "ناظر زين!!"
    let questionNumber = 4

    let answers = ["", "", "", ""]

    var body: some View {
        VStack(spacing: 0) {
            // الهيدر ورقم السؤال
            HStack {
                Image("BUTTON.HOME")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .padding(.leading, 16)
                Spacer()
                HStack(spacing: 4) {
                    ForEach(0..<3) { _ in
                        Image("HEART")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.trailing, 16)
            }
            .padding(.top, 70)

            HStack {
                Image("PAGENUMBER")
                    .resizable()
                    .frame(width: 42, height: 42)
                    .overlay(
                        Text("\(questionNumber)")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    )
                    .padding(.leading, 32)
                Spacer()
            }

            Spacer(minLength: 60)

            Text(questionText)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, 32)

            Spacer(minLength: 20)

            // الأزرار
            VStack(spacing: 20) {
                HStack(spacing: 24) {
                    makeButton(index: 0)
                    makeButton(index: 1)
                }
                HStack(spacing: 24) {
                    makeButton(index: 2)
                    makeButton(index: 3)
                }
            }
            .padding(.horizontal, 16)

            Spacer(minLength: 100)

            // شريط التخطي
            ZStack {
                let skipBarImageName: String = {
                    switch skipCount {
                    case 0: return "SKIP.BAR.1"
                    case 1: return "SKIP.BAR.2"
                    case 2: return "SKIP.BAR.3"
                    case 3, 4: return "SKIP.BAR.4"
                    default: return "SKIP.BAR.1"
                    }
                }()
                Image(skipBarImageName)
                    .resizable()
                    .frame(width: 216, height: 52)
                let slotOffsets: [CGFloat] = [87, 29, -20, -80]
                if skipCount < 4 {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            skipCount += 1
                        }
                    }) {
                        Image("SKIP.BUTTON")
                            .resizable()
                            .frame(width: 56.5, height: 56.5)
                    }
                    .offset(x: slotOffsets[skipCount], y: 1)
                }
            }
            .padding(.bottom, 32)
            .padding(.trailing, -100)
        }
        .onAppear {
            // يخفي الألوان بعد ثانية واحدة
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showColors = false
                }
            }
        }
        .ignoresSafeArea()
    }

    // دالة إنشاء الأزرار
    func makeButton(index: Int) -> some View {
        Button(action: {
            guard !showColors else { return }
            if selectedAnswer == nil {
                selectedAnswer = index
            }
        }) {
            ZStack {
                // الشكل الافتراضي للزر
                Image("BUTTON.REGULAR")
                    .resizable()
                    .frame(width: 150, height: 70)

                // في أول ثانية فقط، تظهر ألوان التلميح
                if showColors {
                    if index == correctIndex {
                        Image("BUTTON.CORRECT")
                            .resizable()
                            .frame(width: 150, height: 70)
                            .transition(.opacity)
                    } else {
                        Image("BUTTON.REGULAR")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.red.opacity(0.7))
                            .frame(width: 150, height: 70)
                            .transition(.opacity)
                    }
                } else {
                    // إذا المستخدم اختار الإجابة الصحيحة
                    if selectedAnswer == index && index == correctIndex {
                        Image("BUTTON.CORRECT")
                            .resizable()
                            .frame(width: 150, height: 70)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    question4()
}


