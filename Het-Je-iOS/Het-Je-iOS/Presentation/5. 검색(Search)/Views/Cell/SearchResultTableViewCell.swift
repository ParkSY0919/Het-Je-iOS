//
//  SearchResultTableViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import UIKit

import SnapKit
import Then

final class SearchResultTableViewCell: UITableViewCell {
    
    private let aboutCoinView = AboutCoinComponent(type: .detail, imageURL: "", titleText: "", subtitleText: "", rankTag: 0)
    private let favoriteBtn = FavoriteButtonComponent()
    private let star = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSearchResultCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //이 친구를 nil 대응하려면 fetch 함수 속 받는 model을 nil로 받아야하는데 보통 그렇게 사용하나?
//        aboutCoinView.fetchAboutCoinComponent(model: ??)
        favoriteBtn.isSelected = false
    }
    
    private func setSearchResultCell() {
        contentView.addSubviews(aboutCoinView, favoriteBtn)
        
        aboutCoinView.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.trailing.equalTo(favoriteBtn.snp.leading).offset(-10)
        }
        
        favoriteBtn.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(20)
        }
    }
    
    func fetcHSearchResultCell(model: DTO.Response.Search.Coin) {
        aboutCoinView.fetchAboutCoinComponent(model: model)
    }
    
}
