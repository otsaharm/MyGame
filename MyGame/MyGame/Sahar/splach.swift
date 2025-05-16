//
//  splach.swift
//  MyGame
//
//  Created by Sahar Otiyn on 14/11/1446 AH.
//

import SwiftUI

struct splach: View {
    @State private var isActive = true
    @State private var size = 0.8
    @State private var opacity = 0.5

    var body: some View {
        ZStack {
            if isActive {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Image("habbash") // Replace "Habbash" with the actual name of your image asset
                            .resizable()
                            .scaledToFit()
                            .frame(width: 600, height: 600)
                        Text("Habbash")
                            .font(.system(size: 55, weight: .bold))

                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top,-490)

                    }
                    
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) { // Duration of the splash screen
                        withAnimation {
                            self.isActive = false
                        }
                    }
                }
            } else {
            }
        }
    }
}

struct splach_Previews: PreviewProvider {
    static var previews: some View {
        splach()
    }
}
