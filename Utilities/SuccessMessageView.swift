import SwiftUI


struct SuccessMessageView: View {
    private let messages = ["Great Job", "Excellent", "Perfect"]
    private let images = ["great","excellent", "perfect"]
    
    private var randomIndex:Int {
        return Int.random(in: 0...2)
    }
    
    @State private var animationsRunning = false
    
    @State private var randomPositions: [RandomPosition] = []
    
    private func generateRandomPositions() {
        randomPositions = (1...20).map { _ in
            RandomPosition(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...600))
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(images[randomIndex])
                .resizable()
                .scaledToFit()
                .frame(width:300,height:300)
            
            HStack {
                Image(systemName: "music.note")
                
                Text(messages[randomIndex])
                
                Image(systemName: "music.note")
                
            }
            .symbolEffect(.bounce, options: .repeating, value: animationsRunning)
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.bold)
            
            
            Spacer()
        }
        .padding()
        .onAppear() {
            animationsRunning = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        
        
    }
}




