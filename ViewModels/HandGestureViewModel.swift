import Combine
import SwiftUI

class HandGestureViewModel: ObservableObject {
    static let shared = HandGestureViewModel()
    
    @Published var currentHandGesture:String = ""
    
    @Published var isDoPinched: Bool = false
    @Published var isRePinched: Bool = false
    @Published var isMiPinched: Bool = false
    @Published var isFaPinched: Bool = false
    @Published var isSolPinched: Bool = false
    @Published var isRaPinched: Bool = false
    @Published var isSiPinched: Bool = false
    @Published var isHighDoPinched: Bool = false
    
    private init() {}
    
}

