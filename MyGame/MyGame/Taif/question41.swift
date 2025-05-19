import SwiftUI

struct question41: View {
    @State private var skipCount = 0
    @State private var carPosition = CGPoint(x: -10, y: -200)
    @State private var playerOffset = CGPoint(x: 10, y: 140)
    @State private var hasWon = false
    @State private var pageNumber = "٤١"
    var onNext: () -> Void = {}

    @State private var currentPath = "none"

    @State private var redUp1 = 0
    @State private var redRight = 0
    @State private var redUp2 = 0

    @State private var greenRight = 0
    @State private var greenUp = 0
    @State private var greenLeft = 0

    let startPoint = CGPoint(x: 10, y: 140)

    var body: some View {
        UIforAll(skipCount: $skipCount, pageNumber: $pageNumber) {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer(minLength: 100) // تم تقليلها من 150 إلى 100

                    ZStack {
                        Image("game41")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: geo.size.width * 0.78, height: geo.size.width * 0.78)
                            .padding(.vertical, 10)

                        Image("boysincar")
                            .resizable()
                            .frame(width: 80, height: 60)
                            .offset(x: carPosition.x, y: carPosition.y)

                        if hasWon {
                            VStack(spacing: 8) {
                                Text("مبروك، وصلت للسيارة!")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.green.opacity(0.95))
                                    .cornerRadius(16)
                            }
                            .offset(x: carPosition.x, y: carPosition.y - 60)
                            .zIndex(2)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                    onNext()
                                }
                            }
                        }

                        Image("boy3")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .offset(x: playerOffset.x, y: playerOffset.y)
                            .animation(.easeInOut, value: playerOffset)
                    }

                    VStack(spacing: -8) {
                        HStack {
                            Spacer()
                            Button(action: {
                                if currentPath == "none" && playerOffset == startPoint {
                                    currentPath = "red"
                                }

                                if currentPath == "red" {
                                    if redUp1 < 2 {
                                        playerOffset.y -= 10
                                        redUp1 += 1
                                    } else if redUp1 == 2 && redRight == 13 && redUp2 < 10 {
                                        playerOffset.y -= 10
                                        redUp2 += 1
                                    }
                                }

                                if currentPath == "green" {
                                    if greenRight == 16 && greenUp < 31 && greenLeft == 0 {
                                        playerOffset.y -= 10
                                        greenUp += 1
                                    }
                                }
                            }) {
                                Image("arrowup22")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer()
                        }

                        HStack {
                            Button(action: {
                                if currentPath == "red" {
                                    if redRight > 0 && redUp2 == 0 {
                                        playerOffset.x -= 10
                                        redRight -= 1
                                    }
                                }

                                if currentPath == "green" {
                                    if greenRight == 16 && greenUp == 31 && greenLeft < 14 {
                                        playerOffset.x -= 10
                                        greenLeft += 1
                                        if greenLeft == 14 {
                                            hasWon = true
                                        }
                                    } else if greenRight > 0 && greenUp == 0 && greenLeft == 0 {
                                        playerOffset.x -= 10
                                        greenRight -= 1
                                    }
                                }
                            }) {
                                Image("arrowleft")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }

                            Spacer().frame(width: 48)

                            Button(action: {
                                if currentPath == "none" && playerOffset == startPoint {
                                    currentPath = "green"
                                }

                                if currentPath == "red" {
                                    if redUp1 == 2 && redRight < 13 && redUp2 == 0 {
                                        playerOffset.x += 10
                                        redRight += 1
                                    }
                                }

                                if currentPath == "green" {
                                    if greenRight < 16 && greenUp == 0 && greenLeft == 0 {
                                        playerOffset.x += 10
                                        greenRight += 1
                                    } else if greenRight == 16 && greenUp == 31 && greenLeft > 0 {
                                        playerOffset.x += 10
                                        greenLeft -= 1
                                    }
                                }
                            }) {
                                Image("arrowright")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                        }

                        HStack {
                            Spacer()
                            Button(action: {
                                if currentPath == "red" {
                                    if redUp2 > 0 {
                                        playerOffset.y += 10
                                        redUp2 -= 1
                                    } else if redUp1 > 0 && redRight == 0 {
                                        playerOffset.y += 10
                                        redUp1 -= 1
                                    }
                                }

                                if currentPath == "green" {
                                    if greenUp > 0 && greenLeft == 0 {
                                        playerOffset.y += 10
                                        greenUp -= 1
                                    }
                                }
                            }) {
                                Image("arrowdown")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 180)
                    .padding(.top, 32) // تم تقليلها من 64 إلى 32

                    Spacer(minLength: 40)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .onChange(of: playerOffset) { newValue in
                    if newValue == startPoint {
                        resetRed()
                        resetGreen()
                        currentPath = "none"
                    }
                }
            }
        }
    }

    func resetAll() {
        playerOffset = CGPoint(x: 10, y: 140)
        hasWon = false
        resetRed()
        resetGreen()
        currentPath = "none"
    }

    func resetRed() {
        redUp1 = 0
        redRight = 0
        redUp2 = 0
    }

    func resetGreen() {
        greenRight = 0
        greenUp = 0
        greenLeft = 0
    }
}

#Preview {
    question41()
}
