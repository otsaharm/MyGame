import SwiftUI

struct UIforAll<Content: View>: View {
    @Binding var skipCount: Int
    @Binding var pageNumber: String
    let maxSkips = 4
    let content: Content

    init(skipCount: Binding<Int>, pageNumber: Binding<String>, @ViewBuilder content: () -> Content) {
        self._skipCount = skipCount
        self._pageNumber = pageNumber
        self.content = content()
    }

    var skipBarImageName: String {
        switch skipCount {
        case 0: return "SKIP.BAR.1"
        case 1: return "SKIP.BAR.2"
        case 2: return "SKIP.BAR.3"
        case 3, 4: return "SKIP.BAR.4"
        default: return "SKIP.BAR.1"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    Image("BUTTON.HOME")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.leading, 24)
                    Spacer()
                    HStack(spacing: 4) {
                        ForEach(0..<3) { _ in
                            Image("HEART")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .padding(.trailing, 24)
                }
                .padding(.top, 55)

                // Page Number Display
                HStack {
                    Image("PAGENUMBER")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .overlay(
                            Text(pageNumber)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .padding(.leading, 32)
                    Spacer()
                }
                .padding(.top, 10)

                Spacer(minLength: 0)

                content
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)

                Spacer(minLength: 150)

                ZStack {
                    Image(skipBarImageName)
                        .resizable()
                        .frame(width: 216, height: 52)

                    let slotOffsets: [CGFloat] = [87, 29, -20, -80]
                    if skipCount < maxSkips {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                if skipCount < maxSkips {
                                    skipCount += 1
                                }
                            }
                        }) {
                            Image("SKIP.BUTTON")
                                .resizable()
                                .frame(width: 56.5, height: 56.5)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .offset(x: slotOffsets[skipCount], y: 1)
                    }
                }
                .padding(.bottom, 32)
                .padding(.trailing, -100)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}

// Preview
#Preview {
    @State var previewSkip = 0
    @State var previewPage = "٢٣"
    return UIforAll(skipCount: $previewSkip, pageNumber: $previewPage) {
        VStack {
            Text("مثال على المحتوى").font(.title)
        }
        .padding()
    }
}
