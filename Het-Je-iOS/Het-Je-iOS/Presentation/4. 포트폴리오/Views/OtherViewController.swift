//
//  OtherViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

import SnapKit

final class OtherViewController: BaseViewController {
    
    let label = VariationRateComponent.rateType(rate: 0.00514, alignment: .right)
    let customView = AboutCoinComponent(type: .detail, imageURL: "케케몬", titleText: "OM", subtitleText: "MANTRA", rankTag: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(label, customView)
        label.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        customView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func setStyle() {
        view.backgroundColor = .brown
//        print(labe)
    }
    
}
