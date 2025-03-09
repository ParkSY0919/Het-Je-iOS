//
//  PopularNFTCollectionViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import UIKit

import SnapKit
import Then

final class PopularNFTCollectionViewCell: UICollectionViewCell {
    
    private let coinImageView = UIImageView()
    private let nftNameLabel = UILabel()
    private let nativeCurrencySymbolLabel = UILabel()
    private let floorPriceInNativeCurrencyLabel = UILabel()
    private let variationRateLabel = VariationRateComponent(variationRateType: .rise(rate: "45.7", alignment: .center))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCell() {
        contentView.addSubviews(coinImageView,
                                nftNameLabel,
                                nativeCurrencySymbolLabel,
                                floorPriceInNativeCurrencyLabel,
                                variationRateLabel)
        
        coinImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(72)
        }
        
        nftNameLabel.snp.makeConstraints {
            $0.top.equalTo(coinImageView.snp.bottom).offset(8)
            $0.centerX.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        nativeCurrencySymbolLabel.snp.makeConstraints {
            $0.top.equalTo(nftNameLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(contentView.safeAreaLayoutGuide).offset(2)
            
        }
        
        floorPriceInNativeCurrencyLabel.snp.makeConstraints {
            $0.top.equalTo(nativeCurrencySymbolLabel.snp.top)
            $0.centerX.equalTo(contentView.safeAreaLayoutGuide).offset(-2)
        }
        
        variationRateLabel.snp.makeConstraints {
            $0.top.equalTo(floorPriceInNativeCurrencyLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(nftNameLabel.snp.centerX)
        }
        
        coinImageView.setImageKfDownSampling(with: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159", cornerRadius: 22)
        
        nftNameLabel.setLabelUI("Meebits", font: .hetJeFont(.body_bold_9), textColor: .primary)
        
        nativeCurrencySymbolLabel.setLabelUI(
            "ETH",
            font: .hetJeFont(.body_regular_12),
            textColor: .secondary,
            alignment: .left
        )
        
        floorPriceInNativeCurrencyLabel.setLabelUI(
            "0.66 ",
            font: .hetJeFont(.body_regular_12),
            textColor: .secondary,
            alignment: .right
        )
    }
    
}
