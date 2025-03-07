//
//  PaddingLabel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

final class PaddingLabel: UILabel {
    
    private let horizontalInset: CGFloat = 4.0 //left, right 각각
    private let verticalInset: CGFloat = 2.0 //top, bottom 각각
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        super.drawText(in: rect.inset(by: insets))
    }
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalInset + horizontalInset, height: size.height + verticalInset + verticalInset)
    }
    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (horizontalInset + horizontalInset) }
    }
    
}
