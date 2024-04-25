import SwiftUI

struct PracticeCameraView: View {
    
    @ObservedObject var handGestureViewModel = HandGestureViewModel.shared
    
    @State private var animationsRunning = false
    @State private var isLeftHand = true
    
    @ObservedObject private var practiceViewModel = PracticeViewModel.shared
    @State private var currentOneHandIndex = 0
    
    @State private var currentPage = 0
    @State private var currentBothHandIndex = 0
    
    var imageTransitionWidth:CGFloat = 500
    
    @State private var isFinished = false
    @State private var isOnBoarding = true
    
    var body: some View {
        
        if isOnBoarding {
            OnBordingCameraView(isOnBoarding: $isOnBoarding)
        }
        else if isFinished {
            SuccessMessageView()
        }
        else {
            GeometryReader { geometry in
                CameraSwiftUITransView()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        HStack {
                            
                            if !practiceViewModel.testHandItem.indices.contains(currentOneHandIndex){
                                HStack {
                                    Spacer()
                                    VStack {
                                        ScoreCard(item: practiceViewModel.testBothHandScore, currentPage: $currentPage, currentIndex: $currentBothHandIndex, imageTransitionWidth:imageTransitionWidth, isFinished: $isFinished)
                                            .frame(width: imageTransitionWidth, height: 210)
                                            .padding()
                                        Spacer()
                                    }.padding(.top, 25)
                                    Spacer()
                                }
                            }
                            else if !animationsRunning && handGestureViewModel.currentHandGesture != practiceViewModel.testHandItem[currentOneHandIndex].targetScore {
                                
                                TestHandCard(item: practiceViewModel.testHandItem[currentOneHandIndex])
                                    .padding()
                                    .frame(width: geometry.size.width, height: geometry.size.height) // ZStack 안에서 VStack의 크기 지정
                                    .offset(x: isLeftHand ? geometry.size.width / 4 : -geometry.size.width / 4, y: 0)
                                
                            }
                            else {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .frame(width:400,height: 700)
                                    .overlay(
                                        Image(systemName: "music.quarternote.3")
                                            .onAppear {
                                                animationsRunning = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    currentOneHandIndex += 1
                                                    animationsRunning = false
                                                    if currentOneHandIndex > 3 {
                                                        isLeftHand = false
                                                    }
                                                    
                                                }
                                            }
                                            .font(.largeTitle)
                                            .foregroundColor(.green)
                                            .symbolEffect(.bounce, options: .repeating, value: animationsRunning)
                                    )
                                    .padding()
                                    .frame(width: geometry.size.width, height: geometry.size.height) // ZStack 안에서 VStack의 크기 지정
                                    .offset(x: isLeftHand ? geometry.size.width / 4 : -geometry.size.width / 4, y: 0)
                                
                            }
                            
                        }
                        
                        
                    )
            }
        }
        
    }
}




