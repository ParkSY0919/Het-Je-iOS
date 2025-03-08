//
//  ExchangeTableViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

import SnapKit
import Then

final class ExchangeTableViewCell: UITableViewCell {

    private let marketLabel = UILabel()
    private let currentPriceLabel = UILabel()
    private let prevDayPercentageLabel = UILabel()
    private let prevDayNumLabel = UILabel()
    private let tradePayoutLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubviews(marketLabel,
                                currentPriceLabel,
                                prevDayPercentageLabel,
                                prevDayNumLabel,
                                tradePayoutLabel)
    }
    
    func setLayout() {
        marketLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).offset(22)
            $0.width.equalTo(100)
        }
        
        currentPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(marketLabel.snp.centerY)
            $0.trailing.equalTo(prevDayPercentageLabel.snp.trailing).offset(-70)
            $0.leading.lessThanOrEqualTo(marketLabel.snp.trailing).offset(10)
        }
        
        prevDayPercentageLabel.snp.makeConstraints {
            $0.centerY.equalTo(marketLabel.snp.centerY)
            $0.trailing.equalTo(tradePayoutLabel.snp.trailing).offset(-100)
            $0.leading.lessThanOrEqualTo(currentPriceLabel.snp.trailing)
        }
        
        prevDayNumLabel.snp.makeConstraints {
            $0.top.equalTo(prevDayPercentageLabel.snp.bottom)
            $0.trailing.equalTo(prevDayPercentageLabel.snp.trailing)
            $0.leading.lessThanOrEqualTo(prevDayPercentageLabel.snp.leading)
        }
        
        tradePayoutLabel.snp.makeConstraints {
            $0.centerY.equalTo(marketLabel.snp.centerY)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-22)
            $0.leading.lessThanOrEqualTo(prevDayNumLabel.snp.trailing)
        }
    }
    
    private func setStyle() {
        self.selectionStyle = .none
    }
    
    func configureCell(model: DTO.Response.MarketData) {
        marketLabel.setLabelUI(
            model.market,
            font: .hetJeFont(.body_bold_12),
            textColor: .primary,
            alignment: .left
        )
        
        currentPriceLabel.setLabelUI(
            CustomFormatterManager.shard.formatNum(num: model.tradePrice, isTradePrice: true),
            font: .hetJeFont(.body_regular_12),
            textColor: .secondary,
            alignment: .right
        )
        
        let color: UIColor = model.signedChangeRate > 0.00 ? .plus : .minus
        prevDayPercentageLabel.setLabelUI(
            CustomFormatterManager.shard.formatNum(num: model.signedChangeRate) + "%",
            font: .hetJeFont(.body_regular_12),
            textColor: color,
            alignment: .right
        )
        prevDayNumLabel.setLabelUI(
            CustomFormatterManager.shard.formatNum(
                num: model.signedChangePrice
            ),
            font: .hetJeFont(.body_regular_9),
            textColor: color,
            alignment: .right
        )
        
        tradePayoutLabel.setLabelUI(
            CustomFormatterManager.shard.formatAddTradePrice(num: model.accTradePrice24h),
            font: .hetJeFont(.body_regular_12),
            textColor: .secondary,
            alignment: .right
        )
    }
    
}
