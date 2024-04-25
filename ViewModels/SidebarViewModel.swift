import SwiftUI

class SidebarViewModel: ObservableObject {
    enum SidebarSelection: Hashable {
        case welcome
        case guide
        case practice
        case play
    }
    
    static let shared = SidebarViewModel()
    private init() {}
    
    @Published var selection: SidebarSelection? = .welcome
    @Published var columnVisibility = NavigationSplitViewVisibility.all
    
    func select(_ selection: SidebarSelection) {
        self.selection = selection
    }
}

