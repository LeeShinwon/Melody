import SwiftUI

struct TestHandCard: View {
    
    let item: TestHandItem
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
            .frame(width:400,height: 700)
            .overlay(
                VStack {
                    Text(item.score)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    
                    Text(item.isLeftHand ? "✋🏻 Left Hand ✋🏾" : "🤚🏻 Right Hand 🤚🏾")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.top, -15)
                    
                    Image(item.scoreImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 50)
                        .padding()
                    
                    Image(item.handImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 400)
                        .padding()
                    
                }
                
            )
    }
}

