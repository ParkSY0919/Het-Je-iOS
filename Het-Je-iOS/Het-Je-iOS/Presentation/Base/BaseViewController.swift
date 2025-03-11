//
//  BaseViewController.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import UIKit

import Network
import SnapKit
import Then
import Toast

class BaseViewController: UIViewController {
    
    private let monitor = NWPathMonitor()
    private var alreadyPresent = false
    
    let underLine = UIView()
    private let loadingView = LoadingView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUnderLine()
        setHierarchy()
        setLayout()
        setStyle()
        view.backgroundColor = .white
        startMonitoring()
    }
    
    private func setUnderLine() {
        view.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(2)
        }
        underLine.backgroundColor = UIColor.bg
    }
    
//    func setLoadingView() {
//        
//    }
    
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
    
    func showToast(message: String, isNetworkToast: Bool = false) {
        var style = ToastStyle()
        style.backgroundColor = .secondary
        style.titleColor = .primary
        style.cornerRadius = 10
        
        let duration: Double = isNetworkToast ? 1 : 2.5
        view.makeToast(message, duration: duration, position: .bottom, style: style)
    }
    
    func isLoading(isLoading: Bool) {
        switch isLoading {
        case true:
            showLoadingView()
        case false:
            hideLoadingView()
        }
    }
    
    private func showLoadingView() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loadingView.isLoading = true
        
        //로딩 시 탭바 속성 변경
        if let tabBarVC = self.tabBarController as? TabBarController {
            tabBarVC.setTabBarAppearence(onLoading: true)
        }
    }
    
    private func hideLoadingView() {
        loadingView.isLoading = false
        if let tabBarVC = self.tabBarController as? TabBarController {
            tabBarVC.setTabBarAppearence()
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
    
    func checkNetworkStatus() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
        
    func resetMonitoring() {
        alreadyPresent = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension BaseViewController {
    
    func startMonitoring() {
        monitor.start(queue: .global())
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                //이미 alert이 표시되고 있다면 추가 동작 X
                if self.alreadyPresent {
                    return
                }
                
                if path.status == .satisfied {
                    print("인터넷 연결 상태 양호: 알림 닫힘")
                } else {
                    //인터넷 연결 X = alert
                    self.showNetworkAlert()
                }
            }
        }
    }
    
    func showNetworkAlert() {
        //중복 alert 방지
        if let presentedVC = self.presentedViewController, presentedVC is NetworkGuidanceViewController {
            print("이미 네트워크 알림이 표시 중입니다.")
            return
        }
        
        let vc = NetworkGuidanceViewController()
        vc.baseViewController = self
        viewTransition(viewController: vc, transitionStyle: .overCurrentContext)
        alreadyPresent = true
        print("네트워크 알림 표시됨")
    }
    
}


