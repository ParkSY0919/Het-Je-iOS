//
//  ExchangeViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

import SnapKit
import Then

final class ExchangeViewController: BaseViewController {
    
    private let exchangeTableView = UITableView(frame: .zero)
    
    private let container = UIView()
    private let coinLabel = UILabel()
    private let currentPriceSortButton = SortButtonComponent(title: "현재가")
    private let changeRateSortButton = SortButtonComponent(title: "전일대비")
    private let volumeSortButton = SortButtonComponent(title: "거래대금")
    
    // 현재 활성화된 정렬 버튼을 추적하기 위한 변수
    private var activeSortButton: SortButtonComponent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
    }
    
    override func setHierarchy() {
        view.addSubviews(container, exchangeTableView)
        
        container.addSubviews(
            coinLabel,
            currentPriceSortButton,
            changeRateSortButton,
            volumeSortButton
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
                
        currentPriceSortButton.snp.makeConstraints {
            $0.centerY.equalTo(coinLabel.snp.centerY)
            $0.trailing.equalTo(changeRateSortButton.snp.trailing).offset(-70)
            
            // width에 대한 고정값과 우선순위 설정
            $0.width.equalTo(60).priority(999)
            $0.width.lessThanOrEqualTo(100)
            
            // height에 대한 고정값과 우선순위 설정
            $0.height.equalTo(30).priority(999)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
                
        changeRateSortButton.snp.makeConstraints {
            $0.centerY.equalTo(coinLabel.snp.centerY)
            $0.trailing.equalTo(volumeSortButton.snp.trailing).offset(-100)
            
            // width에 대한 고정값과 우선순위 설정
            $0.width.equalTo(60).priority(999)
            $0.width.lessThanOrEqualTo(100)
            
            // height에 대한 고정값과 우선순위 설정
            $0.height.equalTo(30).priority(999)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
                
        volumeSortButton.snp.makeConstraints {
            $0.centerY.equalTo(coinLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-22)
            
            // width에 대한 고정값과 우선순위 설정
            $0.width.equalTo(60).priority(999)
            $0.width.lessThanOrEqualTo(100)
            
            // height에 대한 고정값과 우선순위 설정
            $0.height.equalTo(30).priority(999)
            $0.height.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
                
        coinLabel.setLabelUI("코인", font: .hetJeFont(.body_bold_12), textColor: .primary, alignment: .left)
    }
    
    override func setStyle() {
        container.backgroundColor = .bg
        
        exchangeTableView.do {
            $0.rowHeight = 35
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.id)
            if #available(iOS 17.4, *) {
                //바운스 막기
                //$0.bouncesVertically = false
            }
        }
        
        currentPriceSortButton.delegate = self
        changeRateSortButton.delegate = self
        volumeSortButton.delegate = self
        
        resetAllSortButtons(isFirstRun: true)
    }
}

// MARK: - Private Extension
private extension ExchangeViewController {
    
    func setNav() {
        let label = UILabel()
        label.setLabelUI(
            StringLiterals.TabBar.exchangeTitle,
            font: UIFont.systemFont(ofSize: 24, weight: .heavy),
            textColor: UIColor.primary
        )
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    //모든 sortButton 상태 초기화
        //단, 첫 시작 시 거래대금 내림차순 시작
    func resetAllSortButtons(isFirstRun: Bool = false) {
        currentPriceSortButton.setState(.none)
        changeRateSortButton.setState(.none)
        isFirstRun ? volumeSortButton.setState(.descending) : volumeSortButton.setState(.none)
        activeSortButton = nil
    }
    
    func updateSortButtonStates(selectedButton: SortButtonComponent) {
        // 이미 활성화된 버튼이 현재 선택된 버튼과 같은 경우
        if activeSortButton == selectedButton {
            // 상태 순환: none -> descending -> ascending -> none
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
            activeSortButton = selectedButton
        }
        
        sortAndRefreshData()
    }
    
    func sortAndRefreshData() {
        exchangeTableView.reloadData()
    }
    
}

// MARK: - SortButtonDelegate
extension ExchangeViewController: SortButtonDelegate {
    
    func sortButtonDidTap(_ button: SortButtonComponent) {
        updateSortButtonStates(selectedButton: button)
    }
    
}

// MARK: - TableView
extension ExchangeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mockMarketData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.id, for: indexPath) as! ExchangeTableViewCell
        cell.setLayout()
        cell.configureCell(model: mockMarketData[indexPath.row])
        
        return cell
    }
    
}
