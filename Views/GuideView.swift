import SwiftUI

struct GuideView: View {
    @ObservedObject private var sidebarViewModel = SidebarViewModel.shared
    @ObservedObject private var practiceViewModel = PracticeViewModel.shared
    
    var body: some View {
        NavigationStack {
            VStack  {
                ScrollView (showsIndicators: false) {
                    VStack {
                        
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                            Text("Caution")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.gradient))
                        
                        Text("Errors may occur during the camera setup process.\nIf you encounter a camera error or the tips of your fingers are not recognized properly,\n please exit the app and restart it.")
                            .fontWeight(.bold)
                            .font(.system(size:20))
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.bottom, 50)
                        
                        
                        HStack {
                            Image(systemName: "target")
                            Text("Practice")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.gradient))
                        
                        
                        Text("You can practice moving your fingers to produce sounds from Do to HighDo in real-time.")
                            .padding()
                        
                        Text("First, practice Do, Re, Mi, Fa with your left hand,\nand then proceed to practice Sol, Ra, Si, HighDo with your right hand.\nAfterward, test both hands together from Do to HighDo.")
                            .padding()
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            
                            Image("leftHandTest")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 150)
                                .padding()
                            
                            Image("rightHandTest")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 150)
                                .padding()
                            
                            Image("bothHandsTest")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 250, height: 150)
                                .padding()
                            
                        }.padding(.vertical, 50)
                        
                        
                        Text("Left Hand")
                            .fontWeight(.bold)
                            .font(.title2)
                            .padding(.top, 50)
                            .padding()
                        
                        
                        
                        HStack {
                            ForEach (0..<4) { i in
                                VStack {
                                    Text(practiceViewModel.testHandItem[i].score)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    
                                    Text(practiceViewModel.testHandItem[i].isLeftHand ? "✋🏻 Left Hand ✋🏾" : "🤚🏻 Right Hand 🤚🏾")
                                        .foregroundColor(.black)
                                        .padding()
                                        .padding(.top, -15)
                                    
                                    Image(practiceViewModel.testHandItem[i].scoreImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 30)
                                        .padding()
                                    
                                    Image(practiceViewModel.testHandItem[i].handImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 250)
                                        .padding()
                                    
                                }.padding()
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.gradient))
                                    .padding()
                                
                                
                            }
                        }
                        
                        Text("Right Hand")
                            .fontWeight(.bold)
                            .font(.title2)
                            .padding()
                            .padding(.top, 30)
                            
                        HStack {
                            ForEach (4..<8) { i in
                                VStack {
                                    Text(practiceViewModel.testHandItem[i].score)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    
                                    Text(practiceViewModel.testHandItem[i].isLeftHand ? "✋🏻 Left Hand ✋🏾" : "🤚🏻 Right Hand 🤚🏾")
                                        .foregroundColor(.black)
                                        .padding()
                                        .padding(.top, -15)
                                    
                                    Image(practiceViewModel.testHandItem[i].scoreImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 30)
                                        .padding()
                                    
                                    Image(practiceViewModel.testHandItem[i].handImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 250)
                                        .padding()
                                    
                                }.padding()
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.gradient))
                                    .padding()
                                
                                
                            }
                        }
                        
                        
                        HStack {
                            Image(systemName: "music.note")
                            Text("Play Melody")
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green.gradient))
                        .padding(.top, 100)
                        .padding()
                        
                        Text("You can play melodies following the musical score.\nTry playing \"Twinkle Twinkle Little Star\" and \"Jingle Bells.\"")
                            .padding()
                        
                        Text("Additionally, by selecting the green \"Melody\", you can freely play any melody you desire.")
                            .fontWeight(.bold)
                            .padding(.bottom, 50)
                        
                        HStack {
                            Image("PlayMelody_1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 200)
                                .padding()
                            
                            Image("PlayMelody_2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 200)
                                .padding()
                        }
                        .padding()
                    }
                    .padding()
                    
                    
                }
                
                
                
                Spacer()
                Button(action: {
                    self.sidebarViewModel.select(.practice)
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "target")
                        Text("Practice")
                        
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
            .navigationTitle("Guide")
        }
    }
}


