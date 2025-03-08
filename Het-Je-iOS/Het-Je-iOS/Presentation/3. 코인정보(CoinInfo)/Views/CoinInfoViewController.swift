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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
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
