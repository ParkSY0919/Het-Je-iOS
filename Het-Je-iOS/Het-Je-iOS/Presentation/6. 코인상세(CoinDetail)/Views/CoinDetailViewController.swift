//
//  CoinDetailViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class CoinDetailViewController: BaseViewController {
    
    enum CoinDetailCollectionViewSectionType: CaseIterable {
        case 차트
        case 종목정보
        case 투자지표
    }
    
    private let sectionTypes = CoinDetailCollectionViewSectionType.allCases
    private let viewModel: CoinDetailViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    
    init(viewModel: CoinDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        bind()
    }
    
    override func setHierarchy() {
        view.addSubview(detailCollectionView)
    }
    
    override func setLayout() {
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        detailCollectionView.do {
            $0.register(CoinTrendCollectionViewCell.self, forCellWithReuseIdentifier: CoinTrendCollectionViewCell.id)
            $0.register(CoinPriceRangeCollectionViewCell.self, forCellWithReuseIdentifier: CoinPriceRangeCollectionViewCell.id)
            $0.register(CoinValuationCollectionViewCell.self, forCellWithReuseIdentifier: CoinValuationCollectionViewCell.id)
            $0.register(CoinDetailHeaderView.self, forSupplementaryViewOfKind: CoinDetailHeaderView.elementKinds, withReuseIdentifier: CoinDetailHeaderView.elementKinds)
            
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
}

private extension CoinDetailViewController {
    
    func bind() {
        let input = CoinDetailViewModel.Input(
            in_TapNavLeftBtn: self.navigationItem.leftBarButtonItem?.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.out_TapNavLeftBtn?
            .drive(with: self, onNext: { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        output.out_ReloadCollectionViewData
            .filter { isLoad in
                print("isLoad: \(isLoad)")
                return isLoad
            }
            .bind(with: self) { owner, _ in
                owner.detailCollectionView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    func setNav() {
        setNavTitleView()
        setNavLeftRightitem()
        self.navigationController?.navigationBar.tintColor = .primary
    }
    
    func setNavTitleView() {
        let titleView = UIView()
        let label = UILabel()
        let image = UIImageView()
        titleView.addSubviews(image, label)
        
        label.setLabelUI(
            viewModel.coinData.symbol,
            font: UIFont.systemFont(ofSize: 16, weight: .heavy),
            textColor: UIColor.primary
        )
        
        image.setImageKfDownSampling(with: viewModel.coinData.thumb, cornerRadius: 0)
        
        image.snp.makeConstraints {
            $0.size.equalTo(15)
            $0.centerY.leading.equalTo(titleView)
            //equalToSuperView or titleView.snp.centerY 하면 아직 titleView가 nav.titleView에 등록 전이기에 앱이 터짐
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(10)
            $0.centerY.equalTo(image)
        }
        
        titleView.snp.makeConstraints {
            $0.width.equalTo(label.snp.width).offset(15 + 10) //이미지 크기 + 간격
            $0.height.equalTo(30)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    func setNavLeftRightitem() {
        let item = UIBarButtonItem(image: AppIconType.left.image, style: .done, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = item
        
        let rightItem = FavoriteButtonComponent()
        rightItem.fetchFavoriteBtn(coinInfo: viewModel.coinData)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItem)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            switch self?.sectionTypes[sectionIndex] {
            case .차트:
                return self?.createHorizontalScrollSection(sectionType: .차트)
            case .종목정보:
                return self?.createHorizontalScrollSection(sectionType: .종목정보)
            case .투자지표:
                return self?.createHorizontalScrollSection(sectionType: .투자지표)
            case .none:
                return self?.createHorizontalScrollSection(sectionType: .투자지표)
            }
        }
    }
    
    private func createHorizontalScrollSection(sectionType: CoinDetailCollectionViewSectionType) -> NSCollectionLayoutSection {
        switch sectionType {
        case .차트:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10)
            
            section.boundarySupplementaryItems = []
            
            return section
        case .종목정보:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(130))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(35))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: CoinDetailHeaderView.elementKinds,
                                                                     alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        case .투자지표:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(170))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(170))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(35))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: CoinDetailHeaderView.elementKinds,
                                                                     alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
    
}

extension CoinDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch sectionTypes[indexPath.section] {
        case .종목정보, .투자지표:
            //.차트 case는 layout 잡을 때 header의 높이를 0으로 설정함
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: CoinDetailHeaderView.elementKinds,
                                                                               for: indexPath) as? CoinDetailHeaderView
            else { return UICollectionReusableView() }
            
            let title = (sectionTypes[indexPath.section] == .종목정보) ? "종목정보" : "투자지표"
            header.configureHeaderView(headerTitle: title)
            
            return header
        case .차트:
            return UICollectionReusableView(frame: .zero)
        }
    }
}

extension CoinDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sectionTypes[indexPath.section] {
            
        case .차트:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinTrendCollectionViewCell.id, for: indexPath) as! CoinTrendCollectionViewCell
            cell.fetchCoinTrendCell(model: viewModel.list, currentTime: viewModel.currentTime)
            
            return cell
        case .종목정보:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinPriceRangeCollectionViewCell.id, for: indexPath) as! CoinPriceRangeCollectionViewCell
            cell.configurePriceRangeCell(model: viewModel.list)
            return cell
        case .투자지표:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinValuationCollectionViewCell.id, for: indexPath) as! CoinValuationCollectionViewCell
            cell.fetchCoinValuationCell(model: viewModel.list)
            return cell
        }
    }
    
}
