//
//  Item.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import Foundation
import SwiftData

@Model
final class Dream {
    @Attribute(.unique) let uuid = UUID()
    
    var added: Date
    var dreamt: Date
    
    var isLucid: Bool
    var isRecurring: Bool
    var tone: String
    var mood1: String
    var mood2: String
    var mood3: String
    
    var details: String
    var interpretation: String
    
    var audioFilePath: String
    
    init(added: Date = Date(), dreamt: Date = Date(), isLucid: Bool = false, isRecurring: Bool = false, tone: String = "unclear", mood1: String = "neutral", mood2: String = "neutral", mood3: String = "neutral", details: String = "", interpretation: String = "", audioFilePath: String = "") {
            self.added = added
            self.dreamt = dreamt
            self.isLucid = isLucid
            self.isRecurring = isRecurring
            self.tone = tone
            self.mood1 = mood1
            self.mood2 = mood2
            self.mood3 = mood3
            self.details = details
            self.interpretation = interpretation
            self.audioFilePath = audioFilePath
        }
}
