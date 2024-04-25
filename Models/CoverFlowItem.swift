// CoverFlowItem.swift
import SwiftUI

struct CoverFlowItem: Identifiable {
    let id: UUID = .init()
    let index:Int
    var color: Color
    var icon: String
    var title: String
    var description: String
}

