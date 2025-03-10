//
//  FavoriteButtonComponent.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import UIKit

import SnapKit
import Then

final class FavoriteButtonComponent: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setFavoriteButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteButtonStyle() {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(resource: .primary)
        config.baseBackgroundColor = .clear
        self.configuration = config
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.image = AppIconType.star.image
            case .selected:
                button.configuration?.image = AppIconType.star_fill.image
            default:
                return
            }
        }
        self.configurationUpdateHandler = buttonStateHandler
        
        self.addTarget(self,
                             action: #selector(favoriteButtonTapped),
                             for: .touchUpInside)
    }
    
    func fetchFavoriteBtn(isLiked: Bool) {
        self.isSelected = isLiked
    }
    
    @objc
    private func favoriteButtonTapped() {
        self.isSelected.toggle()
        //realm 추가, 삭제 동작 구현
    }
    
}

