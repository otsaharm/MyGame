import SwiftUI

struct StartPage: View {
    @State private var goToVideo1 = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)

                VStack {
                    Button(action: {
                        goToVideo1 = true
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
                        print("تم الضغط على ابدأ")
                    }) {
                        Image("Ebda")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 290)
                            .padding(.top, -210)
                    }
                    Button(action: {
                        print("تم الضغط على استمر")
                    }) {
                        Image("Eas")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .padding(.top, 10)
                    }
                    Spacer()
                }
                NavigationLink(destination: Video1(), isActive: $goToVideo1) {
                    EmptyView()
                }
            }
        }
    }
}
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
