import SwiftUI
import AVFoundation

struct Question19: View {
    @State private var skipCount = 0
    @State private var circlePosition: CGPoint = .zero
    @State private var feedbackIcon: String? = nil
    @State private var feedbackColor: Color = .green
    @State private var questionNumberPosition: CGPoint = CGPoint(x: 40, y: 60)
    @State private var isDraggingQuestion = false
    @State private var audioPlayer: AVAudioPlayer? // لتخزين اللاعب الصوتي

    let grid = [
        ["O", "O", "X"],
        ["", "O", ""],
        ["X", "", "X"]
    ]

    let cellSize: CGFloat = 70
    let spacing: CGFloat = 20
    let correctCell = (row: 2, col: 1)

    var body: some View {
        ZStack {
            UIforAll(skipCount: $skipCount) {
                Text("فوز!")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)

                GeometryReader { geo in
                    let gridOriginX = (geo.size.width - gridWidth()) / 2
                    let gridOriginY = (geo.size.height - gridHeight()) / 2

                    ZStack {
                        // خطوط الشبكة الرمادية
                        ForEach(1..<3) { i in
                            // أفقي
                            Rectangle()
                                .fill(Color.gray.opacity(0.6))
                                .frame(width: gridWidth(), height: 3)
                                .position(
                                    x: gridOriginX + gridWidth() / 2,
                                    y: gridOriginY + CGFloat(i) * (cellSize + spacing) - spacing / 2
                                )
                            // رأسي
                            Rectangle()
                                .fill(Color.gray.opacity(0.6))
                                .frame(width: 3, height: gridHeight())
                                .position(
                                    x: gridOriginX + CGFloat(i) * (cellSize + spacing) - spacing / 2,
                                    y: gridOriginY + gridHeight() / 2
                                )
                        }

                        // الشبكة والرموز
                        VStack(spacing: spacing) {
                            ForEach(0..<3) { row in
                                HStack(spacing: spacing) {
                                    ForEach(0..<3) { col in
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.clear)
                                                .frame(width: cellSize, height: cellSize)

                                            if grid[row][col] == "O" {
                                                Circle()
                                                    .stroke(Color.cyan, lineWidth: 3)
                                                    .frame(width: 50, height: 50)  // زيادة المسافة حول الدائرة
                                            } else if grid[row][col] == "X" {
                                                XShape()
                                                    .stroke(Color.blue, lineWidth: 4)
                                                    .frame(width: 50, height: 50) // زيادة المسافة حول X
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .position(x: geo.size.width / 2, y: geo.size.height / 2)

                        // صورة رقم السؤال
                        Image("PAGENUMBER")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, -60)
                            .frame(width: 42, height: 42)
                            .position(circlePosition == .zero ? questionNumberPosition : circlePosition)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        circlePosition = value.location
                                        questionNumberPosition = value.location
                                        isDraggingQuestion = true
                                    }
                                    .onEnded { _ in
                                        let gridOrigin = CGPoint(
                                            x: gridOriginX,
                                            y: gridOriginY
                                        )
                                        checkDropPosition(origin: gridOrigin)
                                        isDraggingQuestion = false
                                    }
                            )

                        // رقم السؤال (متحرك)
                        Text("٢٢")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 42, height: 42)
                            .padding(.top, -60)
                            .position(questionNumberPosition)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        questionNumberPosition = value.location
                                        circlePosition = value.location
                                        isDraggingQuestion = true
                                    }
                                    .onEnded { _ in
                                        let gridOrigin = CGPoint(
                                            x: gridOriginX,
                                            y: gridOriginY
                                        )
                                        checkDropPosition(origin: gridOrigin)
                                        isDraggingQuestion = false
                                    }
                            )

                        // علامة صح أو خطأ
                        if let icon = feedbackIcon {
                            ZStack {
                                Color.black.opacity(0.3).ignoresSafeArea()
                                Image(systemName: icon)
                                    .font(.system(size: 200))
                                    .foregroundColor(feedbackColor)
                            }
                        }
                    }
                }
            }
        }
    }

    func gridWidth() -> CGFloat {
        (cellSize * 3) + (spacing * 2)
    }

    func gridHeight() -> CGFloat {
        (cellSize * 3) + (spacing * 2)
    }

    func cellFrame(row: Int, col: Int, origin: CGPoint) -> CGRect {
        let x = origin.x + CGFloat(col) * (cellSize + spacing)
        let y = origin.y + CGFloat(row) * (cellSize + spacing)
        return CGRect(x: x, y: y, width: cellSize, height: cellSize)
    }

    // دالة للتحقق من موقع سحب الدائرة
    func checkDropPosition(origin: CGPoint) {
        for row in 0..<3 {
            for col in 0..<3 {
                let frame = cellFrame(row: row, col: col, origin: origin)
                if frame.contains(circlePosition) {
                    // حساب مكان السؤال بناءً على محاذاة X و O
                    let newX = frame.origin.x + (frame.size.width - 42) / 2  // محاذاة عرض الرقم مع X و O
                    let newY = frame.origin.y + (frame.size.height - 42) / 2  // محاذاة ارتفاع الرقم مع X و O
                    
                    // تحديث الموقع بناءً على الحساب الجديد
                    circlePosition = CGPoint(x: newX, y: newY)
                    
                    if row == correctCell.row && col == correctCell.col {
                        feedbackIcon = "checkmark.circle.fill"
                        feedbackColor = .green
                        playSound(isCorrect: true)  // تشغيل صوت الصح
                    } else {
                        feedbackIcon = "xmark.circle.fill"
                        feedbackColor = .red
                        playSound(isCorrect: false)  // تشغيل صوت الخطأ
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        feedbackIcon = nil
                    }
                    return
                }
            }
        }
        feedbackIcon = nil
    }

    // دالة لتشغيل الصوت
    func playSound(isCorrect: Bool) {
        let soundName = isCorrect ? "success" : "failure"
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error)")
            }
        }
    }
}

struct XShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

#Preview {
    Question19()
}
