//
//  WFont.swift
//  weairy
//
//  Created by do hee kim on 2024/03/17.
//

import SwiftUI

enum WFont {
    enum font: String {
        case lato = "Lato"
        case poppin = "Poppin"
    }
    
    enum weight: String {
        case light = "Light"
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
    }
    
    func of(size: CGFloat) -> Font {
        return .custom("", size: size)
    }
    
    static func style(_ font: WFont.font, weight: WFont.weight, size: CGFloat) -> Font {
        return .custom("\(font.rawValue)-\(weight.rawValue)", size: size)
    }
    
}
