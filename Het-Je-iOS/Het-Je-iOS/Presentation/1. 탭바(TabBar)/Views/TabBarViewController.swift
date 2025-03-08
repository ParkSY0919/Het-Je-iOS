//
//  TabBarViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let exchangeVC = UINavigationController(rootViewController: ExchangeViewController(viewModel: ExchangeViewModel()))
    private let coninInfoVC = UINavigationController(rootViewController: OtherViewController())
    private let portfolioVC = UINavigationController(rootViewController: OtherViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        
        setDelegate()
        setStyle()
        setTabBarAppearence()
    }
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setStyle() {
        exchangeVC.do {
            $0.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.exchangeTitle,
                                         image: AppIconType.uptrend_Chart.image,
                                         selectedImage: AppIconType.uptrend_Chart.image)
        }
        
        coninInfoVC.do {
            $0.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.coinInfoTitle,
                                         image: AppIconType.chart_Bar.image,
                                         selectedImage: AppIconType.chart_Bar.image)
        }
        
        portfolioVC.do {
            $0.tabBarItem = UITabBarItem(title: StringLiterals.TabBar.portfolioTitle,
                                         image: AppIconType.star.image,
                                         selectedImage: AppIconType.star_fill.image)
        }
        
        setViewControllers([exchangeVC, coninInfoVC, portfolioVC], animated: true)
        
        self.selectedIndex = 0
    }
    
    private func setTabBarAppearence () {
        let appearence = UITabBarAppearance ()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = UIColor.bg
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = UIColor.primary
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    //탭바 아이템 선택으로인한 화면전환 시 깜빡임 방지
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let fromView = selectedViewController?.view, let toView = viewController.view, fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.0, options: [], completion: nil)
        }
        return true
    }
    
}
