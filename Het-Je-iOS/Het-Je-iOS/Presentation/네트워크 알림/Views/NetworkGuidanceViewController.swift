//
//  NetworkGuidanceViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class NetworkGuidanceViewController: UIViewController {
    
    //baseVC 내부 모니터와 함수에 접근해야 하기에 delegate 받아옴
    weak var baseViewController: BaseViewController?
    private let viewModel = NetworkGuidanceViewModel()
    private let disposeBag = DisposeBag()
    
    private let alertBoxTopView = UIView()
    private let guideLabel = UILabel()
    private let statusLabel = UILabel()
    
    private let underLineView = UIView()
    
    private let alertBoxBottomView = UIView()
    private let retryButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        bind()
    }
    
    private func setHierarchy() {
        view.addSubviews(
            alertBoxTopView,
            underLineView,
            alertBoxBottomView
        )
        
        alertBoxTopView.addSubviews(guideLabel, statusLabel)
        alertBoxBottomView.addSubview(retryButton)
    }
    
    private func setLayout() {
        alertBoxTopView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.centerY.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(100)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(alertBoxTopView.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(alertBoxTopView.safeAreaLayoutGuide)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(alertBoxTopView.safeAreaLayoutGuide).inset(20)
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(alertBoxTopView.snp.bottom)
            $0.horizontalEdges.equalTo(alertBoxTopView.snp.horizontalEdges)
            $0.height.equalTo(1)
        }
        
        alertBoxBottomView.snp.makeConstraints {
            $0.top.equalTo(underLineView.snp.bottom)
            $0.horizontalEdges.equalTo(alertBoxTopView.snp.horizontalEdges)
            $0.height.equalTo(50)
        }
        
        retryButton.snp.makeConstraints {
            $0.center.equalTo(alertBoxBottomView.safeAreaLayoutGuide)
        }
    }
    
    private func setStyle() {
        alertBoxTopView.backgroundColor = .white
        alertBoxBottomView.backgroundColor = .white
        underLineView.backgroundColor = .bg
        
        guideLabel.setLabelUI(
            "안내",
            font: .hetJeFont(.body_bold_12),
            textColor: .primary,
            alignment: .center
        )
        
        statusLabel.setLabelUI(
            StringLiterals.NetworkGuidance.statusLabelText,
            font: .hetJeFont(.body_regular_12),
            textColor: .primary,
            alignment: .center,
            numberOfLines: 0
        )
        
        retryButton.do {
            $0.setTitle(StringLiterals.NetworkGuidance.retryBtnTitle, for: .normal)
            $0.setTitleColor(.primary, for: .normal)
            $0.titleLabel?.font = .hetJeFont(.body_bold_12)
        }
    }
    
    private func bind() {
        let input = NetworkGuidanceViewModel.Input(
            in_retryButtonTapped: retryButton.rx.controlEvent(.touchUpInside)
        )
        
        let output = viewModel.transform(input: input)
        
        output.out_retryButtonTapped
            .bind(with: self) { owner, _ in
                if let baseVC = owner.baseViewController {
                    if baseVC.checkNetworkStatus() {
                        print("인터넷 연결 확인")
                        owner.dismiss(animated: true) {
                            baseVC.resetMonitoring()
                        }
                    } else {
                        print("인터넷 연결 실패")
                        baseVC.showToast(message: StringLiterals.NetworkGuidance.toastMessage, isNetworkToast: true)
                    }
                }
            }.disposed(by: disposeBag)
    }
    
}

