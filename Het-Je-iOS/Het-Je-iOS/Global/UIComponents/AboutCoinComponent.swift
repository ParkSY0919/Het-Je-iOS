//
//  AboutCoinComponent.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

import SnapKit
import Then

final class AboutCoinComponent: UIView {
    enum AboutCoinType {
        case noneDetail
        case detail
        
        var imageSize: CGFloat {
            switch self {
            case .noneDetail: return 26
            case .detail: return 36
            }
        }
        
        var labelPaddingToIcon: CGFloat{
            switch self {
            case .noneDetail: return 4
            case .detail: return 12
            }
        }
        
        var isHidden: Bool {
            switch self {
            case .noneDetail:
                return true
            case .detail:
                return false
            }
        }
    }
    
    private let type: AboutCoinType
    private let iconImageView = UIImageView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let hashTag = PaddingLabel()
    
    init(type: AboutCoinType, imageURL: String, titleText: String, subtitleText: String, rankTag: Int = 0) {
        self.type = type
        super.init(frame: .zero)
        self.configureAboutCoinComponent(
            imageURL: imageURL,
            titleText: titleText,
            subtitleText: subtitleText,
            rankTag: rankTag
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAboutCoinComponent(imageURL: String, titleText: String, subtitleText: String, rankTag: Int = 0) {
        self.addSubviews(
            iconImageView,
            title,
            subtitle,
            hashTag
        )
        
        iconImageView.snp.makeConstraints {
            $0.leading.verticalEdges.equalTo(safeAreaLayoutGuide)
            $0.size.equalTo(type.imageSize)
        }
        
        switch type {
        case .noneDetail:
            title.snp.makeConstraints {
                $0.top.equalTo(iconImageView.snp.top)
                $0.leading.equalTo(iconImageView.snp.trailing).offset(type.labelPaddingToIcon)
                $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20).priority(999)
                $0.width.lessThanOrEqualTo(120)
            }
            
            subtitle.snp.makeConstraints {
                $0.horizontalEdges.equalTo(title.snp.horizontalEdges)
                $0.bottom.equalTo(iconImageView.snp.bottom)
                $0.width.lessThanOrEqualTo(120)
            }
        case .detail:
            title.snp.makeConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(type.labelPaddingToIcon)
                $0.bottom.equalTo(subtitle.snp.top).offset(-3)
            }
            subtitle.snp.makeConstraints {
                $0.leading.equalTo(title.snp.leading)
                $0.bottom.equalTo(iconImageView.snp.bottom)
            }
        }
        
        hashTag.snp.makeConstraints {
            $0.leading.equalTo(title.snp.trailing).offset(8)
            $0.centerY.equalTo(title.snp.centerY)
        }
        
        title.setLabelUI(titleText, font: UIFont.hetJeFont(.body_bold_12), textColor: UIColor.primary)
        
        subtitle.setLabelUI(subtitleText, font: UIFont.hetJeFont(.body_regular_12), textColor: UIColor.secondary)
        
        hashTag.do {
            $0.setLabelUI("#1", font: UIFont.hetJeFont(.body_bold_9), textColor: .secondary, alignment: .center)
            $0.backgroundColor = UIColor.bg
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 4
            $0.isHidden = type.isHidden
        }
    }
    
    func fetchAboutCoinComponent(model: DTO.Response.TrendingCoinDetails) {
        iconImageView.setImageKfDownSampling(with: model.thumb, cornerRadius: Int(type.imageSize)/2)
        
        title.text = model.symbol
        subtitle.text = model.name
    }
    
    func fetchAboutCoinComponent(model: DTO.Response.Search.Coin) {
        iconImageView.setImageKfDownSampling(with: model.thumb, cornerRadius: Int(type.imageSize)/2)
        
        title.text = model.symbol
        subtitle.text = model.name
        
        hashTag.text = "\(model.marketCapRank)"
    }
    
}
