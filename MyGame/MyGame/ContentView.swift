import SwiftUI

struct ContentView: View {
    @State private var isSplashActive = true
    @State private var showQuestion = false
    @State private var currentQuestion = 1
    @State private var skipCount27 = 0 // متغير التخطي للسؤال 27
    let answers27 = ["القمر", "", "الشمس", "زحل"] // الخيارات للسؤال 27
    @State private var skipCount30 = 0

    var body: some View {
        if isSplashActive {
            splach()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            isSplashActive = false
                        }
                    }
                }
        } else if !showQuestion {
            StartPage(
                onStart: {
                    showQuestion = true
                }
            )
        } else {
            switch currentQuestion {
            case 1:
                question1(onNext: { currentQuestion = 2 })
            case 2:
                question2(onNext: { currentQuestion = 3 })
            case 3:
                question3(onNext: { currentQuestion = 4 })
            case 4:
                question4(onNext: { currentQuestion = 5 })
            case 5:
                Question5(onNext: { currentQuestion = 6 })
            case 6:
                question6(onNext: { currentQuestion = 7 })
            case 7:
                question7(onNext: { currentQuestion = 8 })
            case 8:
                question8(onNext: { currentQuestion = 9 })
            case 9:
                Question9(onNext: { currentQuestion = 10 })
            case 10:
                Question10(onNext: { currentQuestion = 11 })
            case 11:
                question11(onNext: { currentQuestion = 12 })
            case 12:
                question12(onNext: { currentQuestion = 13 })
            case 13:
                question13(onNext: { currentQuestion = 14 })
            case 14:
                question14(onNext: { currentQuestion = 15 })
            case 15:
                question15(onNext: { currentQuestion = 16 })
            case 16:
                Question16(onNext: { currentQuestion = 18 })
            case 18:
                question18(onNext: { currentQuestion = 19 })
            case 19:
                Question19(onNext: { currentQuestion = 20 })
            case 20:
                Question20(onNext: { currentQuestion = 21 })
            case 21:
                question21(onNext: { currentQuestion = 22 })
            case 22:
                Question22(onNext: { currentQuestion = 23 })
            case 23:
                Question23(onNext: { currentQuestion = 24 })
            case 24:
                Question24(onNext: { currentQuestion = 26 })
            case 26:
                question26(onNext: { currentQuestion = 27 })
            case 27:
                Question27(
                    skipCont: $skipCount27,
                    answers: answers27,
                    questionNumber: 27,
                    onNext: { currentQuestion = 28 }
                )
            case 28:
                Question28(onNext: { currentQuestion = 29 })
            case 29:
                Question29(onNext: { currentQuestion = 30 })
            case 30:
                Question30(skipCount: $skipCount30, onNext: { currentQuestion = 31 })
            case 31:
                Question31(onNext: { currentQuestion = 32 })
            case 32:
                Question32(onNext: { currentQuestion = 33 })
            case 33:
                Question33(onNext: { currentQuestion = 34 })
            case 34:
                Level31View(onNext: { currentQuestion = 35 })
            case 35:
                Question35(onNext: { currentQuestion = 36 })
            case 36:
                Question36(onNext: { currentQuestion = 37 })
            case 37:
                Question37(onNext: { currentQuestion = 38 })
            case 38:
                Question38(onNext: { currentQuestion = 39 })
            case 39:
                Question39(onNext: { currentQuestion = 40 })
            case 40:
                Question40(onNext: { currentQuestion = 41 })
            case 41:
                question41(onNext: { currentQuestion = 42 })
            case 42:
                Question42(onNext: { currentQuestion = 43 })
            case 43:
                Question43()
            case 44:
                Question44(onNext: { currentQuestion = 45 })
            case 45:
                Question45(onNext: { currentQuestion = 46 })
            case 46:
                Question46(onNext: { currentQuestion = 47 })
            case 47:
                Question47(onNext: { currentQuestion = 48 })
            case 48:
                Question48(onNext: { currentQuestion = 49 })
            case 49:
                Question49(onNext: { currentQuestion = 50 })
            default:
                Text("انتهت الأسئلة!")
            }
        }
    }
}

#Preview {
    ContentView()
}
