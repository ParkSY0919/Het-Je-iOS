//
//  CoinPriceRangeCollectionViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import UIKit

import SnapKit
import Then

final class CoinPriceRangeCollectionViewCell: UICollectionViewCell {
    
    private let high24hLabel = UILabel()
    private let high24hPriceLabel = UILabel()
    
    private let low24hLabel = UILabel()
    private let low24hPriceLabel = UILabel()
    
    private let athLabel = UILabel()
    private let athPriceLabel = UILabel()
    private let athDataLabel = UILabel()
    
    private let atlLabel = UILabel()
    private let atlPriceLabel = UILabel()
    private let atlDataLabel = UILabel()
    
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
        contentView.addSubviews(high24hLabel,
                                high24hPriceLabel,
                                low24hLabel,
                                low24hPriceLabel,
                                athLabel,
                                athPriceLabel,
                                atlLabel,
                                atlPriceLabel,
                                athDataLabel,
                                atlDataLabel)
    }
    
    private func setLayout() {
        
        //24시간 고가 실가격
        high24hPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(contentView.snp.centerY).offset(-10)
        }
        //24시간 고가 라벨
        high24hLabel.snp.makeConstraints {
            $0.leading.equalTo(high24hPriceLabel.snp.leading)
            $0.bottom.equalTo(high24hPriceLabel.snp.top).offset(-2)
        }
        //24시간 저가 실가격
        low24hPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.centerX).offset(20)
            $0.bottom.equalTo(high24hPriceLabel.snp.bottom)
        }
        //24시간 저가 라벨
        low24hLabel.snp.makeConstraints {
            $0.leading.equalTo(low24hPriceLabel.snp.leading)
            $0.bottom.equalTo(low24hPriceLabel.snp.top).offset(-2)
        }
        
        //역대 최고가 라벨
        athLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.centerY).offset(2)
            $0.leading.equalTo(high24hPriceLabel.snp.leading)
        }
        athPriceLabel.snp.makeConstraints {
            $0.top.equalTo(athLabel.snp.bottom).offset(2)
            $0.leading.equalTo(athLabel.snp.leading)
        }
        athDataLabel.snp.makeConstraints {
            $0.top.equalTo(athPriceLabel.snp.bottom).offset(1)
            $0.leading.equalTo(athLabel.snp.leading)
        }
        
        atlLabel.snp.makeConstraints {
            $0.top.equalTo(athLabel.snp.top)
            $0.leading.equalTo(low24hPriceLabel.snp.leading)
        }
        
        atlPriceLabel.snp.makeConstraints {
            $0.top.equalTo(atlLabel.snp.bottom).offset(2)
            $0.leading.equalTo(atlLabel.snp.leading)
        }
        atlDataLabel.snp.makeConstraints {
            $0.top.equalTo(atlPriceLabel.snp.bottom).offset(1)
            $0.leading.equalTo(atlLabel.snp.leading)
        }
        
    }
    
    private func setStyle() {
        contentView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
            $0.backgroundColor = .bg
        }
        
        [high24hLabel, low24hLabel, athLabel, atlLabel].forEach { i in
            i.setLabelUI("", font: .hetJeFont(.body_regular_12), textColor: .secondary)
        }
        
        [high24hPriceLabel, low24hPriceLabel, athPriceLabel, atlPriceLabel].forEach { i in
            i.setLabelUI("", font: .hetJeFont(.body_bold_12), textColor: .primary)
        }
        
        [athDataLabel, atlDataLabel].forEach { i in
            i.setLabelUI("", font: .hetJeFont(.body_regular_9), textColor: .secondary)
        }
    }
    
    func configurePriceRangeCell(model: [DTO.Response.MarketAPIResponseModel]) {
        guard let model = model.first else {
            print("fetchCoinTrendCell model 에러 발생")
            return
        }
        
        high24hLabel.text = StringLiterals.CoinDetail.high24hLabel
        high24hPriceLabel.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.high24h)
        
        low24hLabel.text = StringLiterals.CoinDetail.low24hLabel
        low24hPriceLabel.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.low24h)
        
        athLabel.text = StringLiterals.CoinDetail.athLabel
        athPriceLabel.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.ath)
        
        atlLabel.text = StringLiterals.CoinDetail.atlLabel
        atlPriceLabel.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.atl)
        
        athDataLabel.text = CustomFormatterManager.shard.dateFormatOnTrendingView(
            strDate: model.athDate,
            format: "yy.M.dd",
            isCoinDetailDate: true
        )
        atlDataLabel.text = CustomFormatterManager.shard.dateFormatOnTrendingView(
            strDate: model.atlDate,
            format: "yy.M.dd",
            isCoinDetailDate: true
        )
    }
    
}
