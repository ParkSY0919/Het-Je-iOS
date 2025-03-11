//
//  LoadingView.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import UIKit

import SnapKit

final class LoadingView: UIView {
    private let backgroundView = UIView()
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    var isLoading = false {
      didSet {
        self.isHidden = !self.isLoading
        self.isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
      }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        addSubviews(backgroundView, activityIndicatorView)
    }
    
    private func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setStyle() {
        backgroundView.backgroundColor = .black.withAlphaComponent(0.3)
        backgroundView.isUserInteractionEnabled = false //유저 터치 방지
    }
    
}
