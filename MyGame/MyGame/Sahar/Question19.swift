import SwiftUI

struct SimpleXOGameView: View {
    @State private var circlePosition: CGPoint = .zero
    @State private var feedbackIcon: String? = nil
    @State private var feedbackColor: Color = .green

    let grid = [
        ["X", "O", "X"],
        ["X", "X", ""],
        ["O", "", "O"]
    ]

    let cellSize: CGFloat = 80
    let spacing: CGFloat = 15

    // الموقع الصحيح (الصف 3، عمود 2)
    let correctCell = (row: 2, col: 1)

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // الشبكة
                VStack(spacing: spacing) {
                    ForEach(0..<3) { row in
                        HStack(spacing: spacing) {
                            ForEach(0..<3) { col in
                                Text(grid[row][col])
                                    .font(.system(size: 40))
                                    .frame(width: cellSize, height: cellSize)
                                    .background(Color.white)
                                    .border(Color.black, width: 1)
                            }
                        }
                    }
                }
                .position(x: geo.size.width / 2, y: geo.size.height / 2)

                // الدائرة السوداء المتحركة
                Circle()
                    .stroke(Color.black, lineWidth: 3)
                    .frame(width: 30, height: 30)
                    .position(circlePosition == .zero ? CGPoint(x: 40, y: 60) : circlePosition)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                circlePosition = value.location
                            }
                            .onEnded { _ in
                                let gridOrigin = CGPoint(
                                    x: (geo.size.width - gridWidth()) / 2,
                                    y: (geo.size.height - gridHeight()) / 2
                                )
                                checkDropPosition(origin: gridOrigin)
                            }
                    )

                // الرقم الثابت ٢٢
                Text("٢٢")
                    .font(.headline)
                    .foregroundColor(.black)
                    .position(x: 40, y: 60)

                // علامة الصح أو الخطأ
                if let icon = feedbackIcon {
                    ZStack {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        Image(systemName: icon)
                            .font(.system(size: 200))
                            .foregroundColor(feedbackColor)
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

    func cellCenter(row: Int, col: Int, origin: CGPoint) -> CGPoint {
        let x = origin.x + CGFloat(col) * (cellSize + spacing) + cellSize / 2
        let y = origin.y + CGFloat(row) * (cellSize + spacing) + cellSize / 2
        return CGPoint(x: x, y: y)
    }

    func checkDropPosition(origin: CGPoint) {
        let range: CGFloat = cellSize / 2

        for row in 0..<3 {
            for col in 0..<3 {
                let center = cellCenter(row: row, col: col, origin: origin)
                if abs(circlePosition.x - center.x) < range &&
                    abs(circlePosition.y - center.y) < range {

                    if row == correctCell.row && col == correctCell.col {
                        feedbackIcon = "checkmark.circle.fill"
                        feedbackColor = .green
                    } else {
                        feedbackIcon = "xmark.circle.fill"
                        feedbackColor = .red
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        feedbackIcon = nil
                    }

                    return
                }
            }
        }

        // إذا ما نزلها على خلية واضحة، ما يطلع شيء
        feedbackIcon = nil
    }
}

#Preview {
    SimpleXOGameView()
}
