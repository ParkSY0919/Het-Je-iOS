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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
    }
    
    override func setHierarchy() {
        view.addSubview(exchangeTableView)
    }
    
    override func setLayout() {
        exchangeTableView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setStyle() {
        exchangeTableView.do {
            $0.rowHeight = 35
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.id)
            if #available(iOS 17.4, *) {
                //바운스 막기
//                $0.bouncesVertically = false
            }
        }
    }
    
    
}

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
    
}

extension ExchangeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mockMarketData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.id, for: indexPath) as! ExchangeTableViewCell
        
        switch indexPath.row == 0 {
            
        case true:
            cell.setLayout(isFirstCell: true)
        case false:
            cell.setLayout()
            cell.configureCell(model: mockMarketData[indexPath.row - 1])
        }
        
        return cell
    }
    
}
