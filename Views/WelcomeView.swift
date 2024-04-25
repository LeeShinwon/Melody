import SwiftUI

struct WelcomeView: View {
    @ObservedObject private var sidebarViewModel = SidebarViewModel.shared
    
    @State private var animationsRunning = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("welcome")
                    .resizable()
                    .scaledToFit()
                    .frame(width:200, height:200)
                
                HStack {
                    Text("Play")
                    HStack {
                        Text(" Melody ")
                        Image(systemName: "music.note")
                        .symbolEffect(.bounce ,options: .repeat(5), value: animationsRunning)
                    }
                    .font(.title)
                    .foregroundColor(.green)
                    
                    
                    Text("with just a simple flick of your fingers!")
                    
                }
                .fontWeight(.bold)
                .font(.title2)
                .padding()
                
                Spacer()
                VStack(alignment: .center) {
                    Text("Why 'Melody'?")
                        .fontWeight(.bold)
                    
                    VStack (alignment: .leading){
                        Text("Educational Insight")
                            .fontWeight(.bold)
                        Text("'Melody' makes it easy and engaging for beginners to learn melodies, offering a step into the world of music.")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .foregroundColor(.black)
                    .frame(maxWidth: 700)
                    .padding()
                    
                    VStack (alignment: .leading){
                        Text("Rehabilitation & Cognitive Enhancement")
                            .fontWeight(.bold)
                        Text("Through the coordination of eyes and hands, one can expect the development of fine motor skills and enhancement of cognitive abilities.\nIt is particularly beneficial for patients, children, and the elderly.")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .foregroundColor(.black)
                    .frame(maxWidth: 700)
                    .padding()
                    
                    VStack (alignment: .leading){
                        Text("Creative Freedom")
                            .fontWeight(.bold)
                        Text("Craft your own music with your fingers. 'Melody' offers the freedom to express your musical creativity uniquely.")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .foregroundColor(.black)
                    .frame(maxWidth: 700)
                    .padding()
                }
                
                
                
                
                
                Spacer()
                Button(action: {
                    self.sidebarViewModel.select(.guide)
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "info.circle")
                        Text("Guide")
                        
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
                
            }
            .navigationTitle("Welcome")
            .onAppear{
                animationsRunning = true
            }
        }
    }
}



