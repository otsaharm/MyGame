import SwiftUI
import AVKit

struct Video2: View {
    @State private var goToHome = false

    private let player = AVPlayer(url: Bundle.main.url(forResource: "video2", withExtension: "mp4")!)

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
                                goToHome = true
                            }
                        }
                        .ignoresSafeArea()

                    NavigationLink(
                        destination: StartPage()
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true),
                        isActive: $goToHome
                    ) {
                        EmptyView()
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    Video2()
}

