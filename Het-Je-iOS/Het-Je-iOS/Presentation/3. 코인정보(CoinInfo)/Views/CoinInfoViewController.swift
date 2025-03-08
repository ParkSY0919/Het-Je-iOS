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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
    }
    
    override func setHierarchy() {
        view.addSubviews(searchTextField)
    }
    
    override func setLayout() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
    }
    
    override func setStyle() {
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
    
}
