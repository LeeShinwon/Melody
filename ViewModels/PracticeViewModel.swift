import SwiftUI

class PracticeViewModel: ObservableObject {
    static let shared = PracticeViewModel()
    
    private init() {}
    
    @State var testHandItem: [TestHandItem] = [
        TestHandItem(isLeftHand: true, score: "Do(Low)", handImage: "do_hand", scoreImage: "do_score", targetScore: "do"),
        TestHandItem(isLeftHand: true, score: "Re", handImage: "re_hand", scoreImage: "re_score",targetScore: "re"),
        TestHandItem(isLeftHand: true, score: "Mi", handImage: "mi_hand", scoreImage: "mi_score",targetScore: "mi"),
        TestHandItem(isLeftHand: true, score: "Fa", handImage: "fa_hand", scoreImage: "fa_score",targetScore: "fa"),
        TestHandItem(isLeftHand: false, score: "Sol", handImage: "sol_hand", scoreImage: "sol_score",targetScore: "sol"),
        TestHandItem(isLeftHand: false, score: "Ra", handImage: "ra_hand", scoreImage: "ra_score",targetScore: "ra"),
        TestHandItem(isLeftHand: false, score: "Si", handImage: "si_hand", scoreImage: "si_score",targetScore: "si"),
        TestHandItem(isLeftHand: false, score: "Do(High)", handImage: "highDo_hand", scoreImage: "highDo_score",targetScore: "highDo"),
    ]
    
    @State var testBothHandScore: ScoreItem = ScoreItem(color: .green, icon: "target", title: "Practice both hands", totalPage: 1, scorePointPositions: [[70,113,155,195,235,280,320,360]], scorePointsNum: [8], scoreString: [["do","re","mi","fa","sol","ra","si","highDo"]], scoreImages: ["bothHandScore"], soundString: ["doToHighDo"])
    
}

