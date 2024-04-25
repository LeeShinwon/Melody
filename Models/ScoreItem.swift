// ScoreItem.swift

import SwiftUI

struct ScoreItem: Identifiable {
    let id: UUID = .init()
    var color: Color
    var icon: String
    var title: String
    var totalPage: Int
    var scorePointPositions: [[CGFloat]]
    var scorePointsNum: [CGFloat]
    var scoreString: [[String]]
    var scoreImages: [String]
    var soundString: [String]
}

