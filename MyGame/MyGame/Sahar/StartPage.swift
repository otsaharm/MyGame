import SwiftUI

struct StartPage: View {
    var onStart: () -> Void = {}
    var onShowVideo: () -> Void = {}

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                // زر الفيديو (يستدعي onShowVideo)
                Button(action: {
                    onShowVideo()
                }) {
                    Image("video")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                        .padding()
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()

                Image("habbash2")
                    .frame(width: 300, height: 255)
                    .padding(.top)

                Button(action: {
                    onStart()
                }) {
                    Image("Ebda")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 290)
                        .padding(.top, -210)
                }
                Button(action: {
                    onStart()
                }) {
                    Image("Eas")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
