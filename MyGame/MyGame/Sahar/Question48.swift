//
//  Question48.swift
//  MyGame
//
//  Created by Sahar Otiyn on 30/10/1446 AH.
//

import SwiftUI

struct Question48: View {
    // الموقع الحالي للتنورة (لتغيير موقعها عند السحب)
    @State private var skirtPosition = CGSize(width: 150, height: 250)
    
    var body: some View {
        VStack {
            Text("ساعد الفتى المسكين")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, -50)
                .padding(.top, 60)
            
            ZStack {
                // صورة حمام النساء
                Image("men") // تأكد أن صورة حمام النساء موجودة في الـ Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.leading, 200)
                
                Image("men") // تأكد أن صورة حمام النساء موجودة في الـ Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.leading, -200)
                // صورة التنورة
                Image("women") // تأكد من وجود صورة التنورة في الـ Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .padding(.top, 400)
                    .position(x: skirtPosition.width, y: skirtPosition.height) // تحديد موقع التنورة
                
                // إضافة خاصية السحب (Drag)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // تحديث الموقع عند السحب
                                self.skirtPosition = value.translation
                            }
                    )
                
            }
        }
    }
}
struct Question48_Previews: PreviewProvider {
    static var previews: some View {
        Question48()
    }
}



