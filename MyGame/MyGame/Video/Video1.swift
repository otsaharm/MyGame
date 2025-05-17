import SwiftUI
import AVKit

struct Video1: View {
    var onBack: () -> Void

    private let videoURL = Bundle.main.url(forResource: "video1", withExtension: "mov")
    @State private var player: AVPlayer? = nil

    var body: some View {
        ZStack {
            if let url = videoURL {
                if let player = player {
                    VideoPlayer(player: player)
                        .onAppear {
                            player.seek(to: .zero)
                            player.play()
                        }
                        .onDisappear {
                            player.pause()
                        }
                        .ignoresSafeArea()
                } else {
                    ProgressView()
                }
            } else {
                Text("⚠️ ملف الفيديو غير موجود!\nيرجى التأكد من وجود video1.mov في المشروع.")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            VStack {
                HStack {
                    Button(action: {
                        player?.pause()
                        onBack()
                    }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                    .padding(.top, 60) // نزله للأسفل 60 نقطة (غيّر الرقم حسب رغبتك)
                    .padding(.leading)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
            if let url = videoURL {
                player = AVPlayer(url: url)
            }
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
    }
}

#Preview {
    Video1(onBack: {})
}
