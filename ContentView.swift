import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var sidebarViewModel = SidebarViewModel.shared
    
    
    var body: some View {
        NavigationSplitView(columnVisibility: $sidebarViewModel.columnVisibility) {
            List(selection: $sidebarViewModel.selection){
                NavigationLink(value: SidebarViewModel.SidebarSelection.welcome){
                    Label("Welcome", systemImage: "hand.wave")
                }
                
                NavigationLink(value: SidebarViewModel.SidebarSelection.guide){
                    Label("Guide", systemImage: "info.circle")
                }
                
                NavigationLink(value: SidebarViewModel.SidebarSelection.practice){
                    Label("Practice", systemImage: "target")
                }
                NavigationLink(value: SidebarViewModel.SidebarSelection.play){
                    Label("Play Melody", systemImage: "music.note")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Melody")
        } detail: {
            if let selection = sidebarViewModel.selection {
                switch selection {
                case .welcome: WelcomeView()
                case .guide: GuideView()
                case .practice: PracticeView()
                case .play: PlayMelodyView().onAppear {
                    sidebarViewModel.columnVisibility = .detailOnly
                }
                }
            }
            else {
                Text("Select something from the sidebar")
            }
        }
    }
}
