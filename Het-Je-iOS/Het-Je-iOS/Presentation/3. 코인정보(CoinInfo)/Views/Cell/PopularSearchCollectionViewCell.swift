//
//  PopularSearchCollectionViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import UIKit

import SnapKit
import Then

final class PopularSearchCollectionViewCell: UICollectionViewCell {
    
    private let rankLabel = UILabel()
    private lazy var aboutCoinView = AboutCoinComponent(type: .noneDetail, imageURL: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519", titleText: "MOCHI", subtitleText: "Mochi")
    private lazy var variationRateLabel = VariationRateComponent(variationRateType: .reduce(rate: "3.45", alignment: .right))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
        contentView.addSubviews(rankLabel,
                                aboutCoinView,
                                variationRateLabel)
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.safeAreaLayoutGuide)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        variationRateLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.centerY.equalTo(rankLabel.snp.centerY)
        }
        
        aboutCoinView.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(variationRateLabel.snp.leading).offset(0)
            $0.centerY.equalTo(rankLabel.snp.centerY)
        }
        
        rankLabel.setLabelUI(
            "8",
            font: .hetJeFont(.body_regular_12),
            textColor: .primary
        )
    }
    
}
