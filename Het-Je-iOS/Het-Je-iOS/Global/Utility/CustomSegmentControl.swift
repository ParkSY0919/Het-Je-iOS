//
//  CustomSegmentControl.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class CustomSegmentControl: UIView {
    
    let selectedOption = BehaviorRelay<Page?>(value: nil)
    let onChange = PublishRelay<Page>()
    
    private var stackView: UIStackView!
    private var buttons: [UIButton] = []
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupButtons(source: Page.AllCases = Page.allCases) {
        for option in source {
            let button = UIButton()
            let label = UILabel()
            label.do {
                $0.text = "\(option.krName)"
                $0.font = .systemFont(ofSize: 15, weight: .bold)
                $0.textAlignment = .center
            }
            let view = label
            
            button.addSubview(view)
            view.snp.makeConstraints { $0.edges.equalToSuperview() }
            
            button.rx.tap
                .map { option }
                .bind(with: self, onNext: { owner, page in
                    owner.onChange.accept(page)
                }).disposed(by: disposeBag)
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        //underLine 추가
        addUnderline()
        
        //Behavior로 구독 시작 후, compactMap으로 초기 nil값 거르기
        selectedOption
            .compactMap { $0 }
            .subscribe(with: self, onNext: { owner, selected in
                owner.updateUI(selected: selected)
            }).disposed(by: disposeBag)
    }
    
    private func updateUI(selected: Page) {
        for (index, button) in buttons.enumerated() {
            let isSelected = selected.id == Page.allCases[index].id
            button.alpha = isSelected ? 1.0 : 0.5
            button.tintColor = isSelected ? .primary : .secondary
        }
    }
    
    //버튼에 underLine 추가
    //-> 이후 updateUI로 page가 바뀌는 해당 button 속성 따라 underLine 색상도 변경
    private func addUnderline() {
        for button in buttons {
            let underline = UIView()
            underline.backgroundColor = .primary
            button.addSubview(underline)
            underline.snp.makeConstraints {
                $0.height.equalTo(2)
                $0.bottom.leading.trailing.equalToSuperview()
            }
        }
    }
    
}
