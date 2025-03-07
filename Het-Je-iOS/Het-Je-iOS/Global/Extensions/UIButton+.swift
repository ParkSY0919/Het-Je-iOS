//
//  UIButton+.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import UIKit

extension UIButton {
    
    // 모서리둥글게
    func roundedButton(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
}
