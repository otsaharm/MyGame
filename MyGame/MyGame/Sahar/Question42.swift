//
//  Question42.swift
//  MyGame
//
//  Created by Sahar Otiyn on 30/10/1446 AH.
//
import SwiftUI
import Combine
import CoreGraphics

struct Question42: View {
    @State private var hourAngle: Double = 0
    @State private var dragStartAngle: Double = 0
    @State private var selectedHour: Int = 0
    @State private var isCorrect: Bool = false
    @State private var hasAttempted: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isInteractionEnabled: Bool = true

    var body: some View {
        ZStack {
            Image("men")
                .scaledToFill()

            VStack {
                Text("ساعدها! ارجع الوقت.")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()

                ZStack {
                    // خلفية الساعة
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 150, height: 150)

                    // أرقام الساعة
                    ForEach(0..<12) { hour in
                        Text("\(hour == 0 ? 12 : hour)")
                            .font(.caption2)
                            .foregroundColor(.black)
                            .rotationEffect(.degrees(Double(hour) * 30))
                            .offset(y: -65)
                            .rotationEffect(.degrees(-Double(hour) * 30))
                    }

                    // عقرب الدقائق (ثابت)
                    Rectangle()
                        .frame(width: 2, height: 60)
                        .offset(y: -30)
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(0)) // ثابت عند 12

                    // عقرب الساعات (تفاعلي)
                    Rectangle()
                        .frame(width: 3, height: 50)
                        .offset(y: -25)
                        .foregroundColor(.red)
                        .rotationEffect(.degrees(hourAngle))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if isInteractionEnabled {
                                        let center = CGPoint(x: value.startLocation.x - 75, y: value.startLocation.y - 75)
                                        let current = CGPoint(x: value.location.x - 75, y: value.location.y - 75)

                                        let startAngle = atan2(center.y, center.x) * (180 / .pi)
                                        let currentAngle = atan2(current.y, current.x) * (180 / .pi)

                                        var angleDifference = currentAngle - startAngle
                                        if angleDifference > 180 { angleDifference -= 360 }
                                        else if angleDifference < -180 { angleDifference += 360 }

                                        if angleDifference < 0 {
                                            hourAngle += angleDifference * 0.5
                                        }
                                        dragStartAngle = currentAngle
                                    }
                                }
                                .onEnded { _ in
                                    if isInteractionEnabled && !hasAttempted {
                                        hasAttempted = true
                                        checkAnswer()
                                        isInteractionEnabled = false
                                    }
                                }
                        )
                        .animation(.easeInOut(duration: 0.2), value: hourAngle)
                }
                .padding()

                if hasAttempted {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.largeTitle)
                            .padding()
                    } else {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                            .padding()
                    }
                }

                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("تنبيه"), message: Text(alertMessage), dismissButton: .default(Text("حسناً")))
        }
    }

    func checkAnswer() {
        isCorrect = true
        alertMessage = "أحسنت! تم إرجاع الوقت."
        showAlert = true
    }
}

struct ExactClockPuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        Question42()
    }
}
//#Preview {
//    Question42()
//}
