
import SwiftUI
struct question13: View {
    @State private var answerState: AnswerState? = nil
    @State private var skipCount: Int = 0
    @State private var pageNumber: String = "١٣"
    enum AnswerState: Equatable {
        case correct
        case wrong(index: Int)

        static func == (lhs: AnswerState, rhs: AnswerState) -> Bool {
            switch (lhs, rhs) {
            case (.correct, .correct):
                return true
            case let (.wrong(i1), .wrong(i2)):
                return i1 == i2
            default:
                return false
            }
        }
    }

    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            VStack(spacing: 20) {
                Spacer()

                // السؤال في منتصف الشاشة
                ZStack {
                    Text("دور أصعر دائره")
                        .padding(.top,-1)
                        .font(.title)

                    Button(action: {
                        answerState = .correct
                    }) {
                        Circle()
                            .fill(answerState == .correct ? Color.green : Color.black)
                            .frame(width: 4, height: 7)
                    }
                    .offset(x: -3, y: -7) // حسب مكان نقطة الغين
                }
                .padding(.bottom, 60)

                // الدوائر مرتبة بنفس توزيع الصورة المرجعية
                ZStack {
                    // الدائرة 1 (الأكبر) يمين وأسفل
                    circleButton(index: 0)
                        .offset(x: 100, y: 90)

                    // الدائرة 2 يسار وأعلى قليلاً
                    circleButton(index: 1)
                        .offset(x: -100, y: -20)

                    // الدائرة 3 أسفل يسار
                    circleButton(index: 2)
                        .offset(x: -90, y: 120)

                    // الدائرة 4 (الأصغر) فوق في المنتصف تقريباً
                    circleButton(index: 3)
                        .offset(x: 50, y: -40)
                }
                .frame(height: 320)

                Spacer()

                // النتيجة
                if let answerState = answerState {
                    Text(answerState == .correct ? "إجابة صحيحة!" : "إجابة خاطئة! حاول مرة أخرى")
                        .foregroundColor(answerState == .correct ? .green : .red)
                        .font(.title2)
                        .padding(.bottom, 30)
                }
            }
            .padding()
        }
    }

    // زر الدائرة
    func circleButton(index: Int) -> some View {
        Button(action: {
            answerState = .wrong(index: index)
        }) {
            Image("circle\(index+1)")
                .resizable()
                .frame(width: CGFloat(160 - index * 30), height: CGFloat(160 - index * 30))
                .overlay(
                    Circle()
                        .fill(answerState == .wrong(index: index) ? Color.red.opacity(0.4) : Color.clear)
                )
        }
    }
}

#Preview {
    question13()
}
