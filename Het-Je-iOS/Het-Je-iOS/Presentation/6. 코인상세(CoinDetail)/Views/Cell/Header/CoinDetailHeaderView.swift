//
//  CoinDetailHeaderView.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import UIKit

import SnapKit
import Then

final class CoinDetailHeaderView: UICollectionReusableView {
    
    static let elementKinds = "CoinDetailHeaderView"
    
    private let headerTitleLabel = UILabel()
    private let moreButton = UIButton(type: .custom)
    var title: String?
    var onTappedMoreButton: (()->())?
    
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
        self.addSubviews(headerTitleLabel, moreButton)
    }
    
    private func setLayout() {
        headerTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(headerTitleLabel.snp.bottom).offset(6)
        }
    }
    
    private func setStyle() {
        headerTitleLabel.setLabelUI(
            title ?? "headerTitleLabel 실패",
            font: .systemFont(ofSize: 15, weight: .bold),
            textColor: .primary,
            alignment: .left
        )
        
        moreButton.do {
            var config = UIButton.Configuration.plain()
            
            var attributedTitle = AttributedString("더보기")
            attributedTitle.font = .systemFont(ofSize: 13, weight: .bold)
            attributedTitle.foregroundColor = .secondary
            
            config.attributedTitle = attributedTitle
            config.image = AppIconType.right.image
            config.titlePadding = 0
            config.baseForegroundColor = .secondary
            config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10, weight: .regular)
            config.titleAlignment = .trailing
            $0.configuration = config
            $0.semanticContentAttribute = .forceRightToLeft
            $0.addTarget(self, action: #selector(tapMoreButton), for: .touchUpInside)
        }
    }
    
    @objc
    private func tapMoreButton() {
        print(#function)
        onTappedMoreButton?()
    }
    
    func configureHeaderView(headerTitle: String) {
        headerTitleLabel.text = headerTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
    }
    
}
