import SwiftUI


struct PlayMelodyCameraView: View {
    
    @ObservedObject var handGestureViewModel = HandGestureViewModel.shared
    @ObservedObject var playMelodyViewModel = PlayMelodyViewModel.shared
    
    @State private var currentPage = 0
    @State private var currentIndex = 0
    
    var imageTransitionWidth: CGFloat {
        playMelodyViewModel.selectedItemIndex == 0 ? 750 : 800
    }
    
    @State private var animationsRunning = false
    
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
            CameraSwiftUITransView()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    
                    VStack {
                        if playMelodyViewModel.selectedItemIndex != 2 {
                            ScoreCard(item: playMelodyViewModel.scoreItems[playMelodyViewModel.selectedItemIndex], currentPage: $currentPage, currentIndex: $currentIndex, imageTransitionWidth: imageTransitionWidth, isFinished: $isFinished)
                                .frame(width: imageTransitionWidth, height: 210)
                                .padding(.top, 35)
                            
                            Spacer()
                        }
                        
                    }
                )
        }
        
    }
}

