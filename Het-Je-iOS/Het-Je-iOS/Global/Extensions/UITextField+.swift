//
//  UITextField+.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import UIKit

extension UITextField {
    
    //TextField placeholder 커스텀
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: fontColor!, .font: font])
    }
    
}


