//
//  UIFont+Extension.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.10.2022.
//

import SwiftUI

extension Font {
    enum Urbanist {
        enum Bold {
            static func size(of size: CGFloat) -> Font {
                return .custom(Constants.Bold.bold, size: size)
            }
        }
        
        enum Medium {
            static func size(of size: CGFloat) -> Font {
                return .custom(Constants.Medium.medium, size: size)
            }
        }
        
        enum Regular {
            static func size(of size: CGFloat) -> Font {
                return .custom(Constants.Regular.regular, size: size)
            }
        }
        
        enum SemiBold {
            static func size(of size: CGFloat) -> Font {
                return .custom(Constants.SemiBold.semiBold, size: size)
            }
        }
        
    }
}

private extension Font {
    enum Constants {
        enum Black {
            static let black = "Urbanist-Black"
            static let blackItalic = "Urbanist-BlackItalic"
        }
        
        enum Bold {
            static let bold = "Urbanist-Bold"
            static let boldItalic = "Urbanist-BoldItalic"
        }
        
        enum Extra {
            static let extraBold = "Urbanist-ExtraBold"
            static let extraBoldItalic = "Urbanist-ExtraBoldItalic"
            static let extraLight = "Urbanist-ExtraLight"
            static let extraLightItalic = "Urbanist-ExtraLightItalic"
        }
        
        enum Italic {
            static let italic = "Urbanist-Italic"
        }
        
        enum Light {
            static let light = "Urbanist-Light"
            static let lightItalic = "Urbanist-LightItalic"
        }
        
        enum Medium {
            static let medium = "Urbanist-Medium"
            static let mediumItalic = "Urbanist-MediumItalic"
        }
        
        enum Regular {
            static let regular = "Urbanist-Regular"
        }
        
        enum SemiBold {
            static let semiBold = "Urbanist-SemiBold"
            static let semiBoldItalic = "Urbanist-SemiBoldItalic"
        }
        
        enum Thin {
            static let thin = "Urbanist-Thin"
            static let thinItalic = "Urbanist-ThinItalic"
        }
        
        enum Variable {
            static let italicVariable = "Urbanist-Italic-VariableFont_wght"
            static let variable = "Urbanist-VariableFont_wght"
        }
    }
}
