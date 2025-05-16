import SwiftUI

struct question41: View {
    @State private var skipCount = 0

    // مكان السيارة
    @State private var carPosition = CGPoint(x: -10, y: -200)
    // مكان الصبيان (نقطة البداية)
    @State private var playerOffset = CGPoint(x: 0, y: 180)
    @State private var hasWon = false

    @State private var pageNumber: String = "٤١"
    var onNext: () -> Void = {}

    // مسار المستخدم الحالي: "none", "red", "green"
    @State private var currentPath: String = "none"

    // عدادات المسار الأحمر (الأول)
    @State private var upRed = 0
    @State private var leftRed = 0
    @State private var upRed2 = 0

    // عدادات المسار الأخضر (الثاني)
    @State private var leftGreen = 0
    @State private var upGreen = 0
    @State private var leftGreen2 = 0

    @State private var rightCount = 0
    @State private var leftCount = 0

    @State private var upCount = 0

    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer(minLength: 150)
                    ZStack {
                        Image("game41")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: geo.size.width * 0.78, height: geo.size.width * 0.78)
                            .padding(.vertical, 10)
                        // السيارة
                        Image("boysincar")
                            .resizable()
                            .frame(width: 80, height: 60)
                            .offset(x: carPosition.x, y: carPosition.y)
                        // رسالة الفوز
                        if hasWon {
                            VStack(spacing: 8) {
                                Text("🎉 مبروك، وصلت للسيارة!")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.green.opacity(0.95))
                                    .cornerRadius(16)
                            }
                            .offset(x: carPosition.x, y: carPosition.y - 60)
                            .zIndex(2)
                            // الانتقال التلقائي بعد نصف ثانية
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    onNext()
                                }
                            }
                        }
                        // الصبيان
                        Image("boys")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .offset(x: playerOffset.x, y: playerOffset.y)
                            .animation(.easeInOut, value: playerOffset)
                    }
                    // أزرار الأسهم الأربعة تحت الصبيان مباشرة
                    VStack(spacing: -8) {
                        HStack {
                            Spacer()
                            Button(action: {
                                if rightCount == 17 && upCount < 36 && leftCount == 0 {
                                    playerOffset.y -= 10
                                    upCount += 1
                                }
                            }) {
                                Image("arrowup22")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer()
                        }
                        HStack {
                            Button(action: {
                                if rightCount == 17 && upCount == 36 && leftCount < 17 {
                                    playerOffset.x -= 10
                                    leftCount += 1
                                    // شرط الفوز بعد آخر خطوة يسار
                                    if leftCount == 17 {
                                        hasWon = true
                                    }
                                }
                            }) {
                                Image("arrowleft")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer().frame(width: 48)
                            Button(action: {
                                if rightCount < 17 && upCount == 0 && leftCount == 0 {
                                    playerOffset.x += 10
                                    rightCount += 1
                                }
                            }) {
                                Image("arrowright")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                if upCount > 0 {
                                    playerOffset.y += 10
                                    upCount -= 1
                                }
                            }) {
                                Image("arrowdown")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 180)
                    .padding(.top, 64)
                    Spacer(minLength: 40)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

#Preview {
    question41()
}
