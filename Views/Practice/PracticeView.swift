import SwiftUI

struct PracticeView: View {
    
    
    @ObservedObject private var sidebarViewModel = SidebarViewModel.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack (alignment: .center){
                    Image(systemName: "target")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("You can practice moving your fingers\nto produce sounds from Do to HighDo in real-time.")
                        
                        .multilineTextAlignment(.center)
                        .padding()
                        
                    
                    NavigationLink(destination: PracticeCameraView()) {
                        Text("Practice")
                            .padding()
                            .background(Capsule().fill(.white.opacity(0.3)))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.green.gradient))
                .padding()
                .padding()
                
                
                
                Spacer()
                Button(action: {
                    self.sidebarViewModel.select(.play)
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "music.note")
                        Text("Play Melody")
                        
                        Spacer()
                        Image(systemName: "arrow.right")
                        
                    }
                    .frame(minWidth: 200, maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                
            }.navigationTitle("Practice")
            
        }
        
           
        
    }
}


