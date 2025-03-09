//
//  SearchViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class SearchViewController: BaseViewController {
    
    private let viewModel: SearchViewModel
    private let disposeBag = DisposeBag()
    
    private let navBackBtn = UIButton()
    private let navTextField = UITextField()
    
    
    init(viewModel: SearchViewModel, navTitle: String) {
        self.viewModel = viewModel
        super.init()
        
        setNav(text: navTitle)
    }
    
    deinit {
        print("SearchViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
}

private extension SearchViewController {
    
    func bind() {
        let input = SearchViewModel.Input(
            in_TapNavBackButton: navBackBtn.rx.tap
        )
        
        
        let output = viewModel.transform(input: input)
        
        output.out_TapNavBackButton
            .drive(with: self, onNext: { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func setNav(text: String) {
        navBackBtn.do {
            $0.setImage(AppIconType.left.image, for: .normal)
            $0.tintColor = .primary
        }
        
        navTextField.snp.makeConstraints {
            //textField 길이 제한이 없어 200으로 설정하였습니다.
            $0.width.equalTo(200)
        }
        
        navTextField.do {
            $0.text = text
            $0.font = .hetJeFont(.body_regular_12)
            $0.textColor = .primary
            $0.textAlignment = .left
        }
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: navBackBtn), UIBarButtonItem.init(customView: navTextField)]
    }
    
}
