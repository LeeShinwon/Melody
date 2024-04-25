import SwiftUI
import AVFoundation

struct ScoreCard: View {
    let item: ScoreItem
    
    @Binding var currentPage:Int
    @Binding var currentIndex:Int

    @ObservedObject var handGestureViewModel = HandGestureViewModel.shared
    
    @State private var imageTransitionOffset: CGFloat = 0
    @State private var imageInstantTransition: CGFloat?
    
    var imageTransitionWidth: CGFloat?
    
    @State private var isSoundPlaying = 0

    @Binding var isFinished:Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(item.color.gradient)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
            
            
            VStack {
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(.white)
                        .padding()
                    
                    
                    Text(item.title)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding(.leading, -5)
                    
                    Spacer()
                    
                    Text("\(currentPage+1) / \(item.totalPage)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    
                    Image(systemName: "bell.and.waves.left.and.right.fill")
                        .foregroundColor(.black)
                        .symbolEffect(.bounce ,options: .repeat(2), value: isSoundPlaying)
                        .onTapGesture {
                            isSoundPlaying += 1
                            AudioPlayerPlayMelodyManager.shared.playSound(sound: item.soundString[currentPage])
                        }
                        .padding()
    
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .overlay(
                            
                            VStack {
                                Image(item.scoreImages[currentPage])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 400, height:100)
                                    .overlay(
                                        Rectangle()
                                            .fill(item.color.opacity(0.5))
                                            .frame(width: 25, height: 100)
                                            .offset(x:item.scorePointPositions[currentPage][currentIndex], y: 0),
                                        alignment: .leading
                                    )
                                    .padding()
                                    .padding(.top,20)
                                
                            }
                                .padding(.top, -25)
                                .offset(x: imageTransitionOffset, y: 0)
                            
                            
                            
                        )
                        .clipped()
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 3)
                                .blur(radius: 3)
                                .offset(x: 2, y: 2)
                                .mask(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                )
                        )
                        .padding()
                        .padding(.top, -25)
                    
                }
                
            }
        }
        .onChange(of: handGestureViewModel.isDoPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "do",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isRePinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "re",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isMiPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "mi",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isFaPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "fa",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isSolPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "sol",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isRaPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "ra",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isSiPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "si",isNewPinched: newState)
        }
        .onChange(of: handGestureViewModel.isHighDoPinched ) { oldState, newState in
            updateIndexAndPage(scoreName: "highDo",isNewPinched: newState)
        }
        .onChange(of: imageInstantTransition) { oldState, newState in
            if let newValue = newState {
                imageTransitionOffset = newValue
                imageInstantTransition = nil
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    imageTransitionOffset = 0
                }
            }
        }
    }
    
    private func updateIndexAndPage(scoreName: String, isNewPinched: Bool) {
        if isNewPinched && scoreName == item.scoreString[currentPage][currentIndex] {
            
            let currentPageIndices = item.scoreString.indices
            let currentScoreIndices = item.scoreString[currentPage].indices
            
            if currentScoreIndices.contains(currentIndex + 1) {
                currentIndex += 1
            } else {
                if currentPageIndices.contains(currentPage + 1) {
                    currentPage += 1
                    currentIndex = 0
                } else {
                    isFinished = true
                }
            }
        }
    }

}

