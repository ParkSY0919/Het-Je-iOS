//
//  CoinValuationCollectionViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import UIKit

import SnapKit
import Then

final class CoinValuationCollectionViewCell: UICollectionViewCell {
    
    private let marketCapLabel = UILabel()
    private let marketCapPrice = UILabel()
    
    private let fullyDilutedValuationLabel = UILabel()
    private let fullyDilutedValuationPrice = UILabel()
    
    private let totalVolumeLabel = UILabel()
    private let totalVolumePrice = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubviews(marketCapLabel,
                                marketCapPrice,
                                fullyDilutedValuationLabel,
                                fullyDilutedValuationPrice,
                                totalVolumeLabel,
                                totalVolumePrice)
    }
    
    private func setLayout() {
        marketCapLabel.snp.makeConstraints {
            $0.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        marketCapPrice.snp.makeConstraints {
            $0.top.equalTo(marketCapLabel.snp.bottom).offset(2)
            $0.leading.equalTo(marketCapLabel.snp.leading)
        }
        
        fullyDilutedValuationLabel.snp.makeConstraints {
            $0.top.equalTo(marketCapPrice.snp.bottom).offset(16)
            $0.leading.equalTo(marketCapLabel.snp.leading)
        }
        fullyDilutedValuationPrice.snp.makeConstraints {
            $0.top.equalTo(fullyDilutedValuationLabel.snp.bottom).offset(2)
            $0.leading.equalTo(marketCapLabel.snp.leading)
        }
        
        totalVolumeLabel.snp.makeConstraints {
            $0.top.equalTo(fullyDilutedValuationPrice.snp.bottom).offset(16)
            $0.leading.equalTo(marketCapLabel.snp.leading)
        }
        totalVolumePrice.snp.makeConstraints {
            $0.top.equalTo(totalVolumeLabel.snp.bottom).offset(2)
            $0.leading.equalTo(marketCapLabel.snp.leading)
        }
    }
    
    private func setStyle() {
        contentView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
            $0.backgroundColor = .bg
        }
        
        [marketCapLabel, fullyDilutedValuationLabel, totalVolumeLabel].forEach { i in
            i.setLabelUI("", font: .hetJeFont(.body_regular_12), textColor: .secondary)
        }
        
        [marketCapPrice, fullyDilutedValuationPrice, totalVolumePrice].forEach { i in
            i.setLabelUI("", font: .hetJeFont(.body_bold_12), textColor: .primary)
        }
    }
    
    func fetchCoinValuationCell(model: [DTO.Response.MarketAPIResponseModel]) {
        guard let model = model.first else {
            print("fetchCoinTrendCell model 에러 발생")
            return
        }
        marketCapLabel.text = "시가총액"
        fullyDilutedValuationLabel.text = "완전 희석 가치(FDV)"
        totalVolumeLabel.text = "총 거래량"
        
        marketCapPrice.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.marketCap)
        guard let fullyDilutedValuation = model.fullyDilutedValuation else {
            print("fullyDilutedValuation 옵셔널 해제 실패")
            return
        }
        fullyDilutedValuationPrice.text = "₩" + CustomFormatterManager.shard.formatNum(num: fullyDilutedValuation)
        totalVolumePrice.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.totalVolume)
    }
    
}
