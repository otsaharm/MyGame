import SwiftUI
import AVFoundation

struct question12: View {
    @State private var showClosedCat = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var skipCount = 0
    @State private var selectedIndex: Int? = nil

    let answers = [
        "ميو ميو ميو",    // الصحيحة
        "ميو ميو ميو ميو",
        "يميو موي",
        "مياو مياو"
    ]
    let correctIndex = 0
    let questionText = "ايش قالت القطة؟"
    let questionNumber = 12

    var body: some View {
        UIforAll(skipCount: $skipCount) {
            VStack(spacing: 0) {
                Spacer().frame(height: 40)

                // رقم السؤال في الدائرة الزرقاء
                HStack {
                    Image("PAGENUMBER")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .overlay(
                            Text("١٢")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .padding(.leading, 32)
                    Spacer()
                }
                .padding(.top, 8)

                // صورة القطة (تتغير بعد 6 ثوانٍ)
                if showClosedCat {
                    Image("catCLOSED")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .padding(.bottom, 8)
                } else {
                    Image("catOPEN")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .padding(.bottom, 8)
                        .onAppear {
                            playMeow()
                            // بعد 6 ثوانٍ تتغير الصورة
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                withAnimation {
                                    showClosedCat = true
                                }
                            }
                        }
                }

                // نص السؤال
                Text(questionText)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom, 24)

                // الخيارات
                VStack(spacing: 20) {
                    HStack(spacing: 24) {
                        answerButton(text: answers[0], index: 0)
                        answerButton(text: answers[1], index: 1)
                    }
                    HStack(spacing: 24) {
                        answerButton(text: answers[2], index: 2)
                        answerButton(text: answers[3], index: 3)
                    }
                }
                .padding(.horizontal, 16)

                Spacer()
            }
        }
    }

    // زر خيار الإجابة (يصبح أخضر فقط إذا كانت صحيحة ومختارة)
    func answerButton(text: String, index: Int) -> some View {
        Button(action: {
            if selectedIndex == nil {
                selectedIndex = index
            }
        }) {
            ZStack {
                // استخدم صورة الزر الأخضر إذا كانت الإجابة الصحيحة ومختارة
                if selectedIndex == index && index == correctIndex {
                    Image("BUTTON.CORRECT")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                } else {
                    Image("BUTTON.REGULAR")
                        .resizable()
                        .frame(width: 151.68, height: 81)
                }
                Text(text)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(selectedIndex != nil) // يمنع الضغط بعد الاختيار
    }

    // تشغيل صوت القطة مرة واحدة فقط
    func playMeow() {
        if let url = Bundle.main.url(forResource: "meowVoice", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("خطأ في تشغيل الصوت")
            }
        } else {
            print("لم يتم العثور على ملف الصوت")
        }
    }
}

#Preview {
    question12()
}

