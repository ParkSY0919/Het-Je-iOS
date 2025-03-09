//
//  ExchangeViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

final class ExchangeViewController: BaseViewController {
    
    private let viewModel: ExchangeViewModel
    var disposeBag = DisposeBag()
    
    private let exchangeTableView = UITableView(frame: .zero)
    private let container = UIView()
    private let coinLabel = UILabel()
    private let currentPriceSortButton = SortButtonComponent(type: .currentPrice)
    private let prevDaySortButton = SortButtonComponent(type: .prevDay)
    private let tradePayoutSortButton = SortButtonComponent(type: .tradePayout)
    
    init(viewModel: ExchangeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    //다시 돌아왔을 때에 5초뒤 api 받아오는게 아닌, 바로 받아올 수 있도록 수정해야함
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNav()
        bind()
        resetAllSortButtons(isFirstRun: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(#function)
        disposeBag = DisposeBag()
        viewModel.disposeBag = DisposeBag()
    }
    
    override func setHierarchy() {
        view.addSubviews(container, exchangeTableView)
        
        container.addSubviews(
            coinLabel,
            currentPriceSortButton,
            prevDaySortButton,
            tradePayoutSortButton
        )
    }
    
    override func setLayout() {
        container.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(35)
        }
        
        exchangeTableView.snp.makeConstraints {
            $0.top.equalTo(container.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        coinLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(22)
        }
                
        
        //#SortButtonComponent의 크기 설정
            //-> with와 height에 대한 고정값과 우선순위 설정하여 해결
        
        currentPriceSortButton.snp.makeConstraints {
            $0.centerY.equalTo(coinLabel.snp.centerY)
            $0.trailing.equalTo(prevDaySortButton.snp.trailing).offset(-70)
            $0.width.equalTo(60).priority(999)
            $0.width.lessThanOrEqualTo(100)
            $0.height.equalTo(30).priority(999)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
                
        prevDaySortButton.snp.makeConstraints {
            $0.centerY.equalTo(coinLabel.snp.centerY)
            $0.trailing.equalTo(tradePayoutSortButton.snp.trailing).offset(-100)
            $0.width.equalTo(60).priority(999)
            $0.width.lessThanOrEqualTo(100)
            $0.height.equalTo(30).priority(999)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
                
        tradePayoutSortButton.snp.makeConstraints {
            $0.centerY.equalTo(coinLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-22)
            $0.width.equalTo(60).priority(999)
            $0.width.lessThanOrEqualTo(100)
            $0.height.equalTo(30).priority(999)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
                
        coinLabel.setLabelUI(
            StringLiterals.Exchange.marketTitle,
            font: .hetJeFont(.body_bold_12),
            textColor: .primary,
            alignment: .left
        )
    }
    
    override func setStyle() {
        container.backgroundColor = .bg
        
        exchangeTableView.do {
            $0.rowHeight = 35
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.id)
            if #available(iOS 17.4, *) {
                //바운스 막기
                //$0.bouncesVertically = false
            }
        }
    }
    
}

// MARK: - Private Extension
private extension ExchangeViewController {
    
    private func bind() {
        let selectedButton = PublishSubject<SortButtonComponent>()
        
        currentPriceSortButton.tapSubject
            .subscribe(onNext: { [weak self] button in
                self?.updateSortButtonStates(selectedButton: button)
                selectedButton.onNext(button)
            })
            .disposed(by: disposeBag)
        
        prevDaySortButton.tapSubject
            .subscribe(onNext: { [weak self] button in
                self?.updateSortButtonStates(selectedButton: button)
                selectedButton.onNext(button)
            })
            .disposed(by: disposeBag)
        
        tradePayoutSortButton.tapSubject
            .subscribe(onNext: { [weak self] button in
                self?.updateSortButtonStates(selectedButton: button)
                selectedButton.onNext(button)
            })
            .disposed(by: disposeBag)

        let input = ExchangeViewModel.Input(selectedButton: selectedButton.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.sortedListResult
            .drive(exchangeTableView.rx.items(cellIdentifier: ExchangeTableViewCell.id, cellType: ExchangeTableViewCell.self))
            { _, element, cell in
                cell.setLayout()
                cell.configureCell(model: element)
            }
            .disposed(by: disposeBag)
    }

    func setNav() {
        let label = UILabel()
        label.setLabelUI(
            StringLiterals.TabBar.exchangeTitle,
            font: UIFont.systemFont(ofSize: 18, weight: .heavy),
            textColor: UIColor.primary
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    //sortBtn 업데이트 함수
    func updateSortButtonStates(selectedButton: SortButtonComponent) {
        
        //이전 눌린버튼과 같은 버튼이 눌렸다면..
        if viewModel.activeSortButton == selectedButton {
            //none -> descending
            //descending -> ascending
            //ascending -> none
            switch selectedButton.currentState {
            case .none:
                selectedButton.setState(.descending)
            case .descending:
                selectedButton.setState(.ascending)
            case .ascending:
                selectedButton.setState(.none)
            }
        } else {
            resetAllSortButtons()
            selectedButton.setState(.descending)
            viewModel.activeSortButton = selectedButton
        }
        exchangeTableView.reloadData()
    }
    
    //모든 sortButton 상태 초기화
        //단, 첫 시작 시 거래대금 내림차순 시작
    func resetAllSortButtons(isFirstRun: Bool = false) {
        currentPriceSortButton.setState(.none)
        prevDaySortButton.setState(.none)
        tradePayoutSortButton.setState(.none)
        if isFirstRun {
            tradePayoutSortButton.tapSubject.onNext(tradePayoutSortButton)
        }
    }
    
}
