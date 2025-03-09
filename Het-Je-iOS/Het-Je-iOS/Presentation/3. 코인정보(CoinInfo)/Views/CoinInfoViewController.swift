//
//  CoinInfoViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class CoinInfoViewController: BaseViewController {
    
    private let searchTextField = UITextField()
    
    private let popularSearchLabel = UILabel()
    private let dateLabel = UILabel()
    private var popularSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private let popularNFTLabel = UILabel()
    private var popularNFTCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
    }
    
    override func setHierarchy() {
        view.addSubviews(searchTextField,
                         popularSearchLabel,
                         dateLabel,
                         popularSearchCollectionView,
                         popularNFTLabel,
                         popularNFTCollectionView)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        popularSearchLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(30)
            $0.leading.equalTo(searchTextField.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(popularSearchLabel.snp.bottom)
            $0.trailing.equalTo(searchTextField.snp.trailing)
        }
        
        popularSearchCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularSearchLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(350).priority(999)
            $0.height.lessThanOrEqualTo(450)
        }
        
        popularNFTLabel.snp.makeConstraints {
            $0.top.equalTo(popularSearchCollectionView.snp.bottom).offset(15)
            $0.leading.equalTo(popularSearchLabel.snp.leading)
        }
        
        popularNFTCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularNFTLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120).priority(999)
            $0.height.lessThanOrEqualTo(130)
        }
    }
    
    override func setStyle() {
        setSearchTextField()
        
        popularSearchLabel.setLabelUI(
            "인기 검색어",
            font: .systemFont(ofSize: 14, weight: .bold),
            textColor: .primary
        )
        
        dateLabel.setLabelUI(
            "88.88 88:88 기준",
            font: .systemFont(ofSize: 13, weight: .regular),
            textColor: .secondary,
            alignment: .right
        )
        
        popularSearchCollectionView.do {
            $0.showsVerticalScrollIndicator = false
            $0.register(PopularSearchCollectionViewCell.self, forCellWithReuseIdentifier: PopularSearchCollectionViewCell.id)
            $0.delegate = self
            $0.dataSource = self
        }
        
        popularNFTLabel.setLabelUI(
            "인기 NFT",
            font: .systemFont(ofSize: 14, weight: .bold),
            textColor: .primary
        )
        
        popularNFTCollectionView.do {
            $0.showsHorizontalScrollIndicator = false
            $0.register(PopularNFTCollectionViewCell.self, forCellWithReuseIdentifier: PopularNFTCollectionViewCell.id)
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        popularSearchCollectionView.collectionViewLayout = setPopularSearchCollectionViewLayout()
        popularNFTCollectionView.collectionViewLayout = setPopularNFTCollectionViewLayout()
    }

    
}


private extension CoinInfoViewController {
    
    func setNav() {
        let label = UILabel()
        label.setLabelUI(
            StringLiterals.CoinInfo.navTitle,
            font: UIFont.systemFont(ofSize: 18, weight: .heavy),
            textColor: UIColor.primary
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    func setSearchTextField() {
        let containerView = UIView()
        let searchImageView = UIImageView()
        containerView.addSubview(searchImageView)
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(45)
        }
        
        searchImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
        }
        
        searchImageView.do {
            $0.image = AppIconType.search.image
            $0.tintColor = .secondary
            $0.contentMode = .scaleAspectFill
        }
        searchTextField.do {
            $0.leftView = containerView
            $0.leftViewMode = .always
            $0.setPlaceholder(
                placeholder: "검색어를 입력해주세요.",
                fontColor: .secondary,
                font: .systemFont(ofSize: 14, weight: .bold) //주어진 12로 하기에는 글자가 작아 변경
            )
            $0.font = .systemFont(ofSize: 14, weight: .bold)
            $0.layer.borderWidth = 1.5
            $0.layer.borderColor = UIColor.secondary.cgColor
            $0.layer.cornerRadius = 45/2
        }
    }
    
    func setPopularSearchCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let ableScreenWidth = (view.bounds.width - 40 - 20) / 2 //(screenWith - 양쪽inset - cell사이간격)
        layout.do {
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 20
            $0.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            $0.itemSize = CGSize(width: ableScreenWidth, height: (popularSearchCollectionView.bounds.height - 10 * 6)/7) //column 간격*6
        }
        
        return layout
    }
    
    func setPopularNFTCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let ableScreenWidth: CGFloat = 72 //명세서 상 크기
        layout.do {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 10
            $0.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            $0.itemSize = CGSize(width: ableScreenWidth, height: popularNFTCollectionView.bounds.height)
        }
        
        return layout
    }
    
    
    
}

extension CoinInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView == popularSearchCollectionView {
        case true:
            //인기 검색어
            return 14
        case false:
            //인기 NFT
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView == popularSearchCollectionView {
        case true:
            //인기 검색어
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularSearchCollectionViewCell.id, for: indexPath) as! PopularSearchCollectionViewCell
            
            
            
            return cell
        case false:
            //인기 NFT
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularNFTCollectionViewCell.id, for: indexPath) as! PopularNFTCollectionViewCell
            
            return cell
        }
    }
    
}
