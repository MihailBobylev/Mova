//
//  Number+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/1/22.
//

import SwiftUI

fileprivate let baseDeviceHeight: CGFloat = 926
fileprivate let baseDeviceWidth: CGFloat = 428

public extension CGFloat {
    
    var dfs: CGFloat {
        return CGFloat.getDynamicFontSize(size: self)
    }
    
    var dvs: CGFloat {
        return CGFloat.getDynamicVerticalSize(size: self)
    }
    
    var dhs: CGFloat {
        return CGFloat.getDynamicHorizontalSize(size: self)
    }
    
    // Minimum visible font size is 10
    fileprivate static func getDynamicFontSize(size: CGFloat) -> CGFloat{
        return (CGFloat.maximum(10, size * UIScreen.main.bounds.height / baseDeviceHeight))
    }
    
    fileprivate static func getDynamicVerticalSize(size: CGFloat) -> CGFloat{
        return (size * UIScreen.main.bounds.height / baseDeviceHeight)
    }
    
    fileprivate static func getDynamicHorizontalSize(size: CGFloat) -> CGFloat{
        return (size * UIScreen.main.bounds.width / baseDeviceWidth)
    }
}

public extension Int {
    
    var dfs: CGFloat {
        return CGFloat.getDynamicFontSize(size: CGFloat(self))
    }
    
    var dvs: CGFloat {
        return CGFloat.getDynamicVerticalSize(size: CGFloat(self))
    }
    
    var dhs: CGFloat {
        return CGFloat.getDynamicHorizontalSize(size: CGFloat(self))
    }
}

public extension Double {
    
    var dfs: CGFloat {
        return CGFloat.getDynamicFontSize(size: CGFloat(self))
    }
    
    var dvs: CGFloat {
        return CGFloat.getDynamicVerticalSize(size: CGFloat(self))
    }
    
    var dhs: CGFloat {
        return CGFloat.getDynamicHorizontalSize(size: CGFloat(self))
    }
}
