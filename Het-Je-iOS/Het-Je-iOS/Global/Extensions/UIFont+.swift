//
//  UIFont+.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

extension UIFont {
    enum FontName {
        case body_bold_12
        case body_bold_9
        case body_regular_12
        case body_regular_9
         
        var fontWeight: UIFont.Weight {
            switch self {
            case .body_bold_9, .body_bold_12:
                return .bold
            case .body_regular_9, .body_regular_12:
                return .regular
            }
        }
        
        var size: CGFloat {
            switch self {
            case .body_bold_12, .body_regular_12:
                return 12
            case .body_bold_9, .body_regular_9:
                return 9
            }
        }
    }
    
    static func hetJeFont(_ style: FontName) -> UIFont {
        return UIFont.systemFont(ofSize: style.size, weight: style.fontWeight)
    }
    
}

