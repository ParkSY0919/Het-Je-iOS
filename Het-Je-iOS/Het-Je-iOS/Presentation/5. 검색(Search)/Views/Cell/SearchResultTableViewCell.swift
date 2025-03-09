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
    private let star = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSearchResultCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSearchResultCell() {
        contentView.addSubviews(aboutCoinView, star)
        
        aboutCoinView.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.trailing.equalTo(star.snp.leading).offset(-10)
        }
        
        star.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView.safeAreaLayoutGuide)
            $0.size.equalTo(20)
        }
        
        star.image = UIImage(systemName: "star")
        star.tintColor = .primary
    }
    
    func fetcHSearchResultCell(model: DTO.Response.Search.Coin) {
        aboutCoinView.fetchAboutCoinComponent(model: model)
    }
    
}
