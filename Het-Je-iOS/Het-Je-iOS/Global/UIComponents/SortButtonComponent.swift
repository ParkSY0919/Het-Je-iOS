//
//  SortButtonComponent.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

import UIKit

import SnapKit
import Then

final class SortButtonComponent: UIView {
    
    let title: String
    private let label = UILabel()
    private let upImageView = UIImageView()
    private let downImageView = UIImageView()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        
        label.setLabelUI(title, font: .hetJeFont(.body_bold_12), textColor: .primary, alignment: .left)
        
        upImageView.do {
            $0.image = AppIconType.up.image
            $0.contentMode = .scaleAspectFill
            $0.tintColor = .primary
        }
        
        downImageView.do {
            $0.image = AppIconType.down.image
            $0.contentMode = .scaleAspectFill
            $0.tintColor = .primary
        }
        addSubviews(label, upImageView, downImageView)
        
        label.snp.makeConstraints {
            $0.trailing.equalTo(downImageView.snp.leading).offset(-2)
            $0.centerY.equalToSuperview()
        }
        
        upImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.size.equalTo(6)
            $0.bottom.equalToSuperview().multipliedBy(0.5).offset(-0.5)
        }

        downImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.size.equalTo(6)
            $0.top.equalToSuperview().multipliedBy(0.5).offset(0.5)
        }
        
    }
    
}
