//
//  Level31View.swift
//  MyGame
//
//  Created by Sahar Otiyn on 30/10/1446 AH.
//

import SwiftUI

struct Level31View: View {
    @State private var selectedCircles: Set<Int> = []
    
    var body: some View {
        VStack(spacing: 16) {
            // Title
            Text("LEVEL 31")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Question
            Text("How many holes are there in the shirt?")
                .font(.headline)
            
            // Shirt Image with numbered circles
            ZStack {
                // Replace this with your actual image in Assets
                Image("men")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 280)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                // Numbered circles
                numberedCircle(number: 1, x: 0, y: -100)
                numberedCircle(number: 2, x: 50, y: -80)
                numberedCircle(number: 3, x: -60, y: -40)
                numberedCircle(number: 4, x: 60, y: -30)
                numberedCircle(number: 5, x: -40, y: 10)
                numberedCircle(number: 6, x: 40, y: 20)
                numberedCircle(number: 7, x: -20, y: 60)
                numberedCircle(number: 8, x: 20, y: 80)
            }
            .padding()
            
            // Hole count display
            Text("Selected: \(selectedCircles.count)")
                .font(.title2)
            
            // Submit Button
            Button("SUBMIT") {
                print("User submitted \(selectedCircles.count) holes: \(selectedCircles.sorted())")
            }
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
            
            // Bottom icons row
            HStack(spacing: 40) {
                Image(systemName: "magnifyingglass.circle")
                Image(systemName: "calendar")
                Image(systemName: "play.rectangle")
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    // Helper for numbered circles
    func numberedCircle(number: Int, x: CGFloat, y: CGFloat) -> some View {
        Button(action: {
            if selectedCircles.contains(number) {
                selectedCircles.remove(number)
            } else {
                selectedCircles.insert(number)
            }
        }) {
            Text("\(number)")
                .font(.headline)
                .frame(width: 30, height: 30)
                .background(selectedCircles.contains(number) ? Color.green : Color.yellow)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                .foregroundColor(.black)
        }
        .offset(x: x, y: y)
    }
}

#Preview {
    Level31View()
}
