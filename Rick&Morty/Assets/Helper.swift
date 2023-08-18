//
//  Helper.swift
//  Rick&Morty
//
//  Created by Александра Маслова on 17.08.2023.
//

import SwiftUI


// MARK: - colors

extension Color {
   static let darkBackground = Color("DarkBackground")
   static let lightBackground = Color("LightBackground")
    static let label = Color("Label")
    static let subLabel = Color("SubLabel")
    static let description = Color("Description")
    static let accent = Color("Accent")
}

// MARK: - image

extension Image {
    static let planet = Image("Planet")
}

// MARK: - font

extension Font {
    static let detailTitle = Font.custom("Gilroy-Bold", size: 22)
    static let navTitle = Font.custom("Gilroy-Bold", size: 28)
    static let originalTitle = Font.custom("Gilroy-Semibold", size: 17)
    static let subTitle = Font.custom("Gilroy-Semibold", size: 16)
    static let description = Font.custom("Gilroy-Medium", size: 13)
    static let date = Font.custom("Gilroy-Medium", size: 12)
}
