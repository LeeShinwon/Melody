import SwiftUI


struct  CoverFlowCard: View {
    let item: CoverFlowItem

    @State private var isPlayMelodyCameraViewPresented = false
    @ObservedObject var playMelodyViewModel = PlayMelodyViewModel.shared
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(item.color.gradient)
            
            VStack {
                Image(systemName: item.icon)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                Text(item.title)
                    .foregroundStyle(.black)
                    .padding()
                    .fontWeight(.bold)
                    .font(.title2)
                
                Text(item.description)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: {
                    playMelodyViewModel.selectedItemIndex = item.index
                    self.isPlayMelodyCameraViewPresented = true
                }){
                    Text("Play")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                        .background(Capsule().fill(.white.opacity(0.3)))
                }
                .navigationDestination(isPresented: $isPlayMelodyCameraViewPresented) {
                                PlayMelodyCameraView()
                }
                .padding()
                
            }
            
        }
    }
}


