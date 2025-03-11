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
    private let variationRateLabel = VariationRateComponent(variationRateType: .rise(rate: "", alignment: .center))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coinImageView.image = nil
        nftNameLabel.text = nil
        nativeCurrencySymbolLabel.text = nil
        floorPriceInNativeCurrencyLabel.text = nil
        variationRateLabel.text = nil
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
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        nativeCurrencySymbolLabel.snp.makeConstraints {
            $0.top.equalTo(nftNameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.centerX).offset(2)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }

        floorPriceInNativeCurrencyLabel.snp.makeConstraints {
            $0.top.equalTo(nativeCurrencySymbolLabel.snp.top)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide.snp.centerX).offset(-2)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide)
        }

        
        variationRateLabel.snp.makeConstraints {
            $0.top.equalTo(floorPriceInNativeCurrencyLabel.snp.bottom).offset(2)
            $0.centerX.equalTo(nftNameLabel.snp.centerX)
        }
        
        
        
        nftNameLabel.setLabelUI(
            "",
            font: .hetJeFont(.body_bold_9),
            textColor: .primary,
            alignment: .center
        )
        
        nativeCurrencySymbolLabel.setLabelUI(
            "",
            font: .hetJeFont(.body_regular_9),
            textColor: .secondary
        )
        
        floorPriceInNativeCurrencyLabel.setLabelUI(
            "",
            font: .hetJeFont(.body_regular_9),
            textColor: .secondary,
            alignment: .right
        )
    }
    
    func fetchPopularNFTCell(model: DTO.Response.Nft) {
        coinImageView.setImageKfDownSampling(with: model.thumb, cornerRadius: 22)
        nftNameLabel.text = model.name
        nativeCurrencySymbolLabel.text = model.nativeCurrencySymbol
        floorPriceInNativeCurrencyLabel.text = CustomFormatterManager.shard.formatNum(num: model.floorPriceInNativeCurrency)
        variationRateLabel.updateVariationRateType(rate: model.floorPrice24HPercentageChange, alignment: .center)
    }
    
}
