//
//  VariationRateComponent.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

import Then

final class VariationRateComponent: UILabel {
    enum VariationRateType {
        case rise(rate: String, alignment: NSTextAlignment)
        case reduce(rate: String, alignment: NSTextAlignment)
        case none(rate: String, alignment: NSTextAlignment)
        
        var text: String {
            switch self {
            case .rise(let rate, _):
                return "▲ " + rate + "%"
            case .reduce(let rate, _):
                return "▼ " + rate + "%"
            case .none(let rate, _):
                return rate + "%"
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .rise:
                return UIColor.plus
            case .reduce:
                return UIColor.minus
            case .none:
                return UIColor.primary
            }
        }
        
        var alignment: NSTextAlignment {
            switch self {
            case .rise(_, let alignment):
                return alignment
            case .reduce(_, let alignment):
                return alignment
            case .none(_, let alignment):
                return alignment
            }
        }
        
        var font: UIFont {
            return UIFont.hetJeFont(.body_bold_9)
        }
    }
    
    init(variationRateType: VariationRateType) {
        super.init(frame: .zero)
        
        self.setStyle(type: variationRateType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle(type: VariationRateType) {
        self.do {
            $0.text = type.text
            $0.textColor = type.textColor
            $0.font = type.font
            $0.textAlignment = type.alignment
        }
    }
    
    func hideLabel() {
        self.font = .systemFont(ofSize: 0)
    }
    
    func updateVariationRateType(rate: Double, alignment: NSTextAlignment) {
        let rate = CustomFormatterManager.shard.formatNum(num: rate)
        var type: VariationRateType
        
        switch Double(rate) ?? 0.00 > 0 {
        case true:
            type = .rise(rate: rate, alignment: alignment)
        case false:
            type = Double(rate) ?? 0.00 == 0.00 ?
                .none(rate: rate, alignment: alignment) :
                .reduce(rate: rate, alignment: alignment)
        }
        
        self.setStyle(type: type)
    }
    
}
