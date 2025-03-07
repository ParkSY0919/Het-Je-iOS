//
//  UIImageView+.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import UIKit

import SnapKit

extension UIImageView {
    
    func setImageView(image: UIImage, cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.image = image
        self.contentMode = .scaleAspectFit
    }
    
}
