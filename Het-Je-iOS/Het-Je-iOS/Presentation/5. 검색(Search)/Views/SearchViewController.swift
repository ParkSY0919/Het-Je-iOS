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
    
    init(viewModel: SearchViewModel, navTitle: String) {
        self.viewModel = viewModel
        super.init()
        
        print("navTitle: \(navTitle)")
        view.backgroundColor = .brown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
