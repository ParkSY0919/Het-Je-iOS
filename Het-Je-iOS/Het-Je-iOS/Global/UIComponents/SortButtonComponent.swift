//
//  SortButtonComponent.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

import UIKit

import SnapKit
import Then

protocol SortButtonDelegate: AnyObject {
    func sortButtonDidTap(_ button: SortButtonComponent)
}

final class SortButtonComponent: UIView {
    enum SortButtonState {
        case none
        case descending
        case ascending
    }
    
    var currentState: SortButtonState = .none
    weak var delegate: SortButtonDelegate?
    private let title: String
    
    private let label = UILabel()
    private let upImageView = UIImageView()
    private let downImageView = UIImageView()
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupView()
        addTapGesture()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews(label, upImageView, downImageView)
        
        label.setLabelUI(title, font: .hetJeFont(.body_bold_12), textColor: .primary, alignment: .left)
        
        [upImageView, downImageView].forEach { i in
            i.do {
                $0.contentMode = .scaleAspectFill
                $0.image = (i == upImageView) ? AppIconType.up.image : AppIconType.down.image
            }
        }
        
        label.snp.makeConstraints {
            $0.trailing.equalTo(downImageView.snp.leading).offset(-2)
            $0.centerY.equalToSuperview()
        }
        
        upImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.size.equalTo(6)
            $0.centerY.equalToSuperview().offset(-4)
        }

        downImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.size.equalTo(6)
            $0.centerY.equalToSuperview().offset(4)
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSortButton))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc
    func didTapSortButton() {
        delegate?.sortButtonDidTap(self)
    }
    
    //상태별 UI 업데이트
    func updateUI() {
        switch currentState {
        case .none:
            upImageView.tintColor = .secondary
            downImageView.tintColor = .secondary
        case .descending:
            upImageView.tintColor = .secondary
            downImageView.tintColor = .primary
        case .ascending:
            upImageView.tintColor = .primary
            downImageView.tintColor = .secondary
        }
    }
    
    func setState(_ state: SortButtonState) {
        currentState = state
        updateUI()
    }
    
}
