import SwiftUI

struct TestHandItem: Identifiable {
    let id: UUID = .init()
    var isLeftHand: Bool
    var score: String
    var handImage: String
    var scoreImage: String
    var targetScore: String
}

