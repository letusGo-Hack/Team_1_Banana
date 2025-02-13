//
//  Extension+UIScreen.swift
//  DesignSystem
//
//  Created by 서원지 on 6/29/24.
//

import Foundation
import SwiftUI

public extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    static let qrcodeButtonWidth = screenWidth - (screenWidth * 0.1)
    
}
