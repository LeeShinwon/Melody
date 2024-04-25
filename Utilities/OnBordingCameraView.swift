import SwiftUI


struct OnBordingCameraView: View {
    
    @Binding var isOnBoarding:Bool
    
    @State private var isFirst = true
    
    var body: some View {
        
        if isFirst {
            FirstOnboardingView(isFirst: $isFirst)
        }
        else {
            SecondOnboardingView(isOnBoarding: $isOnBoarding)
        }
        
        
    }
}


struct FirstOnboardingView: View {
    
    @Binding var isFirst:Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("💡 For the best hand recognition accuracy,\nplease go to the brightest and most well-lit area possible!")
                .foregroundColor(.white)
                .font(.system(size: 26))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            
            
            HStack {
                VStack {
                    Image("worse_ex")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height:150)
                    
                    Text("X")
                        .foregroundColor(.red)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                
                VStack {
                    Image("bad_ex")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height:150)
                    
                    Text("X")
                        .foregroundColor(.red)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                
                VStack {
                    Image("good_ex")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height:150)
                    
                    Text("O")
                        .foregroundColor(.green)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                
            }
            
            
            Button(action: {
                isFirst = false
            }) {
                Text("Next")
                    .padding()
                
                Image(systemName: "arrow.right")
                    .padding()
            }
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
            .padding()
            
            Spacer()
        }
    }
}


struct SecondOnboardingView: View {
    
    @Binding var isOnBoarding:Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("💡 For the best hand recognition accuracy,\nplease ensure your palm is facing the camera directly!")
                .foregroundColor(.white)
                .font(.system(size: 26))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
            
            HStack {
                VStack {
                    HStack {
                        Image("wrong_left_hand")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height:100)
                        
                        Image("wrong_right_hand")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height:100)
                        
                    }
                    
                    Text("X")
                        .foregroundColor(.red)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                
                
                VStack {
                    HStack {
                        Image("correct_left_hand")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height:100)
                        
                        Image("correct_right_hand")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height:100)
                        
                    }
                    
                    Text("O")
                        .foregroundColor(.green)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
            }
            
            
            
            Button(action: {
                isOnBoarding = false
            }) {
                Text("Start")
                    .padding()
                
                Image(systemName: "arrow.right")
                    .padding()
            }
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
            .padding()
            
            
            Spacer()
        }
    }
}

