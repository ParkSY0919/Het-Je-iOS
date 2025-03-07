//
//  UILabel+.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

extension UILabel {
    
    // 현재 라벨이 잘렸는지 여부
    var isTruncated: Bool {
        guard let text = self.text,
              let font = self.font else { return false }
        
        let labelWidth = self.bounds.width
        let labelHeight = self.bounds.height
        
        let textSize = (text as NSString).boundingRect(
            with: CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        
        return textSize.height > labelHeight
    }
    
    // 모서리둥글게
    func roundedLabel(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    // 특정 텍스트의 색상을 변경해주고, 문단 간격 설정해주는 메소드
    func setAttributedText(fullText: String, pointText: String, pointColor: UIColor, lineHeight: CGFloat) {
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: pointText)
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: pointColor, range: range)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
    
    // 기본 라벨 속성 설정 메소드
    func setLabelUI(_ text: String,
                    font: UIFont,
                    textColor: UIColor,
                    alignment: NSTextAlignment = .left,
                    numberOfLines: Int = 1) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
    
}

