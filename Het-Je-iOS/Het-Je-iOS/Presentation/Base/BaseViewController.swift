//
//  BaseViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    let underLine = UIView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUnderLine()
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func setUnderLine() {
        view.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(2)
        }
        underLine.backgroundColor = UIColor.bg
    }
    
    func setHierarchy() {}
    
    func setLayout() {}
    
    func setStyle() {}
    
    func viewTransition<T: UIViewController>(viewController: T, transitionStyle: ViewTransitionType) {
        switch transitionStyle {
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .resetRootVCwithNav:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let newRootVC = UINavigationController(rootViewController: viewController)
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { window.rootViewController = newRootVC },
                              completion: nil)
            window.makeKeyAndVisible()
        case .resetRootVCwithoutNav:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let newRootVC = viewController
            
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { window.rootViewController = newRootVC },
                              completion: nil)
            window.makeKeyAndVisible()
        case .present:
            return self.present(viewController, animated: true)
        case .presentWithNav:
            let nav = UINavigationController(rootViewController: viewController)
            nav.sheetPresentationController?.prefersGrabberVisible = true
            return self.present(nav, animated: true)
        case .presentFullScreenWithNav:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            return self.present(nav, animated: true)
        case .overCurrentContext:
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            return self.present(viewController, animated: true)
        }
    }
    
    @objc
    func popBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func settingBtnTapped() {
        print(#function)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
