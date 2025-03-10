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
    
    private let viewModel: CoinDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: CoinDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        bind()
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
    
}
