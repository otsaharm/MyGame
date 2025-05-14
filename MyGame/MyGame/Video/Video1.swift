import SwiftUI
import AVKit

struct Video1: View {
    @State private var showEndScreen = false
    @State private var goToVideo2 = false
    @State private var goToVideo3 = false

    private let player = AVPlayer(url: Bundle.main.url(forResource: "video1", withExtension: "mov")!)

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.play()
                            NotificationCenter.default.addObserver(
                                forName: .AVPlayerItemDidPlayToEndTime,
                                object: player.currentItem,
                                queue: .main
                            ) { _ in
                                showEndScreen = true
                            }
                        }
                        .ignoresSafeArea()

                    if showEndScreen {
                        GeometryReader { imageGeo in
                            ZStack {
                                // الصورة
                                Image(uiImage: UIImage(named: "partvidoe") ?? UIImage())
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width)
                                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                                // زر أول (ينقل إلى فيديو 2)
                                Button(action: {
                                    goToVideo3 = true
                                }) {
                                    Color.clear
                                }
                                .frame(width: 129, height: 60)
                                .position(x: 119, y: imageGeo.size.height * 0.59)

                                // زر ثاني (ينقل إلى فيديو 3)
                                Button(action: {
                                    goToVideo2 = true
                                }) {
                                    Color.clear
                                }
                                .frame(width: 129, height: 60)
                                .position(x: 285, y: imageGeo.size.height * 0.59)

                                // التنقل إلى الفيديو 2
                                NavigationLink(destination: Video2(), isActive: $goToVideo2) {
                                    EmptyView()
                                }

                                // التنقل إلى الفيديو 3
                                NavigationLink(destination: Video3(), isActive: $goToVideo3) {
                                    EmptyView()
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Video1()
}
