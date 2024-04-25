// PlayMelodyViewModel.swift
import SwiftUI

class PlayMelodyViewModel: ObservableObject {
    
    static let shared = PlayMelodyViewModel()
    private init() {}
    
    @State var coverFlowItems: [CoverFlowItem] = [
        CoverFlowItem(index:0, color: .yellow, icon: "moon.stars.fill", title: "Twinkle Twinkle Little Star", description: "\"Twinkle Twinkle Little Star\" is a classic English lullaby \nthat describes the wonder of a shining star in the night sky. \nThe song uses a simple melody and repetitive lyrics, making it easily memorable and beloved by children worldwide."),
        CoverFlowItem(index:1,color: .red, icon: "bell.fill", title: "Jingle Bells", description:"A festive holiday anthem, \"Jingle Bells\" \ncaptures the joyful spirit of winter and sleigh riding through snow.\nThe lively rhythm and catchy chorus have made it \na universally recognized classic during the Christmas season."),
        CoverFlowItem(index:2,color: .green, icon: "music.note", title: "Melody", description:"Enjoy playing any melody you like!")
    ]
    
    @State var scoreItems: [ScoreItem] = [
        ScoreItem(color: .yellow, icon: "moon.stars.fill", title: "Twinkle Twinkle Little Star", totalPage: 3, scorePointPositions: [ [-15, 11, 45, 76, 125, 152.5, 187, 261, 287, 315,  340, 387, 414, 440],[-15, 13, 45, 76, 125, 152.5, 187, 258, 285, 315,  342, 387, 414, 440],[-15, 11, 45,76, 125, 152.5, 187, 261, 287, 315,  340, 387, 414, 440]], scorePointsNum: [14,14,14], scoreString: [["do","do","sol","sol","ra","ra","sol","fa","fa","mi","mi","re","re","do"],["sol","sol","fa","fa","mi","mi","re","sol","sol","fa","fa","mi","mi","re"],["do","do","sol","sol","ra","ra","sol","fa","fa","mi","mi","re","re","do"]], scoreImages: ["twinkle_1","twinkle_2","twinkle_3"], soundString:  ["TwinkleSound_1", "TwinkleSound_2","TwinkleSound_1"]),
        
        ScoreItem(color: .red, icon: "bell.fill", title: "Jingle Bells", totalPage: 4, scorePointPositions: [[-53, -23, 10, 100, 134, 165, 255,290,317,350,420],[-95, -62,-30, 0, 72, 105, 140, 170, 240, 270, 305, 337, 410, 470],[-53, -23, 10, 100, 134, 165, 255,290,317,350,420],[-95, -62,-30, 0, 72, 105, 140, 170, 240, 270, 305, 340, 420]], scorePointsNum: [11,14,11,13], scoreString: [["mi","mi","mi","mi","mi","mi","mi","sol","do","re","mi"],["fa","fa","fa","fa","fa","mi","mi","mi","mi","re","re","mi","re","sol"],["mi","mi","mi","mi","mi","mi","mi","sol","do","re","mi"],["fa","fa","fa","fa","fa","mi","mi","mi","sol","sol","fa","re","do"]
       ], scoreImages: ["JingleBells_1","JingleBells_2","JingleBells_3","JingleBells_4"], soundString:["JingleBellsSound_1", "JingleBellsSound_2","JingleBellsSound_1","JingleBellsSound_3"]),
        
    ]
    
    @Published var selectedItemIndex: Int = 0
}


