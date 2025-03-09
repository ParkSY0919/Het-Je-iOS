//
//  UIImageView+.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import UIKit

import Kingfisher

extension UIImageView {
    
    func setImageView(image: UIImage?, cornerRadius: CGFloat = 0) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.image = image
        self.contentMode = .scaleAspectFill
    }
    
    //Downsampling 기능 활용하여 메모리 누수 방지
    func setImageKfDownSampling(with urlString: String?, cornerRadius: Int) {
        var url = ""
        switch urlString == "" || urlString == nil {
        case true:
            self.setEmptyImageView()
        case false:
            guard let urlString else { return }
            url = urlString
            
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: URL(string: url),
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]
            )
            self.clipsToBounds = true
            self.contentMode = .scaleAspectFill
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    func setEmptyImageView(imageStr: String? = "xmark.bin") {
        self.image = UIImage(systemName: imageStr ?? "xmark.bin")
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
        self.tintColor = UIColor.lightGray
    }

    
}
