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
    
}
