import SwiftUI

struct Question37: View {
    @State private var isCorrect = false
    @State private var draggedKeyIndex: Int? = nil
    @State private var keyOffsets: [CGSize] = Array(repeating: .zero, count: 4)
    @State private var showSuccess: Bool = false
    
    let keys = ["KEY.WRONG.1", "KEY.WRONG.2", "KEY.WRONG.3", "KEY.RIGHT"]
    // These positions should be visually tuned for your layout
    let keyPositions: [CGPoint] = [
        CGPoint(x: 250, y: 370), // top right grey
        CGPoint(x: 250, y: 500), // middle right purple
        CGPoint(x: 320, y: 550), // bottom left green
        CGPoint(x: 320, y: 440)  // bottom right (green) yellow
    ]
    // Door lock measurements
    let lockWidth: CGFloat = 192.05
    let lockHeight: CGFloat = 228.24
    let lockX: CGFloat = 31 + 192.05/2
    let lockY: CGFloat = 328 + 228.24/2
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 50) {
                    // Top bar
                    HStack {
                        Image("BUTTON.HOME")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .padding(.leading, 24)
                        Spacer()
                        HStack(spacing: 4) {
                            ForEach(0..<3) { _ in
                                Image("HEART")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                            }
                        }
                        .padding(.trailing, 24)
                    }
                    .padding(.top, 50)
                    // Question number
                    HStack {
                        Image("PAGENUMBER")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .overlay(
                                Text("٣٧")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            )
                            .padding(.leading, 32)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    // Question text
                    Text("وش المفتاح الصح")
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                    Spacer()
                }
                // Door lock and keys
                ZStack {
                    // Door lock
                    Image("DOORLOCK")
                        .resizable()
                        .frame(width: lockWidth, height: lockHeight)
                        .position(x: lockX, y: lockY)
                        .overlay(
                            Group {
                                if showSuccess {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.green)
                                        .offset(x: 40, y: -60)
                                }
                            }
                        )
                    // Keys
                    ForEach(0..<4) { idx in
                        DraggableKey(
                            imageName: keys[idx],
                            idx: idx,
                            offset: $keyOffsets[idx],
                            draggedKeyIndex: $draggedKeyIndex,
                            keySize: CGSize(width: 117, height: 50),
                            keyPosition: keyPositions[idx],
                            lockFrame: CGRect(x: lockX - lockWidth/2, y: lockY - lockHeight/2, width: lockWidth, height: lockHeight),
                            onDrop: { location in
                                // location is in the GeometryReader's coordinate space
                                let lockFrame = CGRect(x: lockX - lockWidth/2, y: lockY - lockHeight/2, width: lockWidth, height: lockHeight)
                                if lockFrame.contains(location) {
                                    if idx == 3 {
                                        // Correct key
                                        isCorrect = true
                                        showSuccess = true
                                    } else {
                                        // Wrong key, shake back
                                        withAnimation(.spring()) {
                                            keyOffsets[idx] = .zero
                                        }
                                    }
                                } else {
                                    // Not dropped on lock, return
                                    withAnimation(.spring()) {
                                        keyOffsets[idx] = .zero
                                    }
                                }
                            }
                        )
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct DraggableKey: View {
    let imageName: String
    let idx: Int
    @Binding var offset: CGSize
    @Binding var draggedKeyIndex: Int?
    let keySize: CGSize
    let keyPosition: CGPoint
    let lockFrame: CGRect
    var onDrop: (CGPoint) -> Void
    
    @GestureState private var dragState = CGSize.zero
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: keySize.width, height: keySize.height)
            .position(keyPosition)
            .offset(offset)
            .gesture(
                DragGesture()
                    .updating($dragState) { value, state, _ in
                        state = value.translation
                    }
                    .onChanged { value in
                        offset = value.translation
                        draggedKeyIndex = idx
                    }
                    .onEnded { value in
                        // Convert the drop location to the GeometryReader's coordinate space
                        let dropLocation = CGPoint(x: keyPosition.x + value.translation.width, y: keyPosition.y + value.translation.height)
                        onDrop(dropLocation)
                        draggedKeyIndex = nil
                    }
            )
            .zIndex(draggedKeyIndex == idx ? 1 : 0)
    }
}

#Preview {
    Question37()
} 
