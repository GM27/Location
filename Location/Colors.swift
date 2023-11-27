//
//  Colors.swift
//  Location
//
//  Created by Jeremy Merezhko on 11/26/23.
//

import Foundation
import SwiftUI

extension Color {
    init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0)
    }
}

// MARK: All app colors
extension Color {
    
    // MARK: Main Colors
    static var almostBlack: Color {return Color(rgb: 0x222426)}
    static var placeholderColor: Color {return Color(rgb: 0x616a73)} // a color of a line, used for x and y axis on charts
    static var mainAppColor: Color {return Color(rgb: 0xe1eaf5)}
    static var mainAppColor2: Color {return Color(rgb: 0xacd1fa)}
    static var mainButtonColor: Color {return Color(rgb: 0x509aed)}
  
}
