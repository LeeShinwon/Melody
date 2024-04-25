
import SwiftUI

struct PlayMelodyView: View {
    var playMelodyViewModel = PlayMelodyViewModel.shared
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Spacer(minLength: 0)
                
                CoverFlowView(
                    itemWidth: 600,
                    enableReflection: true,
                    spacing: 10,
                    rotation: 50,
                    items: playMelodyViewModel.coverFlowItems
                ){ item in
                    CoverFlowCard(item: item)
                }
                .frame(height: 500)
                
                Spacer(minLength: 0)
                
                
            }.navigationTitle("Play Melody")
        }
    }
}

