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
    private lazy var aboutCoinView = AboutCoinComponent(type: .noneDetail, imageURL: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519", titleText: "", subtitleText: "")
    private lazy var variationRateLabel = VariationRateComponent(variationRateType: .reduce(rate: "", alignment: .right))
    
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
            //횡 스크롤 고정 시키고자 특단의 조치 2..
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(-6)
            $0.width.equalTo(14)
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        aboutCoinView.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.trailing.lessThanOrEqualTo(variationRateLabel.snp.leading).inset(2)
            $0.centerY.equalTo(rankLabel.snp.centerY)
        }
        
        variationRateLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
            $0.centerY.equalTo(rankLabel.snp.centerY)
        }
        
        rankLabel.setLabelUI(
            "",
            font: .hetJeFont(.body_regular_12),
            textColor: .primary,
            alignment: .right
        )
    }
    
    func configurePopularSearchCell(model: DTO.Response.Coin) {
        rankLabel.text = "\(model.item.score + 1)"
        aboutCoinView.fetchAboutCoinComponent(model: model.item)
        variationRateLabel.updateVariationRateType(rate: model.item.data.doublePriceChangePercentage24H, alignment: .right)
    }
    
}
