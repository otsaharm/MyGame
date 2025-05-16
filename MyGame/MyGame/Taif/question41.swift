

import SwiftUI

struct question41: View {
    @State private var skipCount = 0

    // غير هذه القيم لتغيير مكان السيارة
    @State private var carPosition = CGPoint(x: -10, y: -200) // مثال: أعلى يمين المتاهة تقريباً

    // غير هذه القيم لتغيير مكان الصبيان (نقطة البداية)
    @State private var playerOffset = CGPoint(x: 0, y: 180) // مثال: أسفل المتاهة تقريباً

    @State private var hasWon = false

    // حدود الحركة (حسب شبكة المتاهة الأصلية)
    let minX: CGFloat = -180
    let maxX: CGFloat = 180
    let minY: CGFloat = -400
    let maxY: CGFloat = 120
    @State private var pageNumber: String = "٤١"
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
                        // السيارة (مكانها متحكم فيه من carPosition)
                        Image("boysincar")
                            .resizable()
                            .frame(width: 80, height: 60)
                            .offset(x: carPosition.x, y: carPosition.y)
                        // رسالة الفوز فوق السيارة مباشرة
                        if hasWon {
                            VStack(spacing: 8) {
                                Text("🎉 مبروك، وصلت للسيارة!")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.green.opacity(0.95))
                                    .cornerRadius(16)
                                Button("حسناً") {
                                    playerOffset = CGPoint(x: 0, y: 120) // يرجع الصبيان لنقطة البداية
                                    hasWon = false
                                }
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.blue)
                                .padding(.top, 2)
                            }
                            .offset(x: carPosition.x, y: carPosition.y - 60) // فوق السيارة مباشرة
                            .zIndex(2)
                        }
                        // الصبيان (مكانهم متحكم فيه من playerOffset)
                        Image("boys")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .offset(x: playerOffset.x, y: playerOffset.y)
                            .animation(.easeInOut, value: playerOffset)
                    }
                    // أزرار التحكم
                    VStack(spacing: -8) {
                        HStack {
                            Spacer()
                            Button(action: { move(dx: 0, dy: -30) }) {
                                Image("arrowup22")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer()
                        }
                        HStack {
                            Button(action: { move(dx: -30, dy: 0) }) {
                                Image("arrowleft")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer().frame(width: 48)
                            Button(action: { move(dx: 30, dy: 0) }) {
                                Image("arrowright")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                        }
                        HStack {
                            Spacer()
                            Button(action: { move(dx: 0, dy: 30) }) {
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

    // منطق الحركة والفوز (مكان السيارة متغير)
    func move(dx: CGFloat, dy: CGFloat) {
        let newX = playerOffset.x + dx
        let newY = playerOffset.y + dy

        // تحقق من الحدود
        if newX < minX || newX > maxX || newY < minY || newY > maxY {
            playerOffset = CGPoint(x: 0, y: 120) // يرجع الصبيان لنقطة البداية
            return
        }

        // تحقق من الفوز (الوصول للسيارة)
        let playerRect = CGRect(x: newX - 30, y: newY - 30, width: 60, height: 60)
        let carRect = CGRect(x: carPosition.x - 30, y: carPosition.y - 30, width: 60, height: 60)
        if playerRect.intersects(carRect) {
            hasWon = true
            return
        }

        // إذا الحركة مسموحة
        playerOffset = CGPoint(x: newX, y: newY)
    }
}

#Preview {
    question41()
}

