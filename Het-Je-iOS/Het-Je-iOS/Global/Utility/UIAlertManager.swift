//
//  UIAlertManager.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//



import UIKit

final class UIAlertManager {
    
    private init() {}
    
    static func showAlert(title: String, message: String, cancelFunc: Bool? = false) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelFunc == true {
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
        }
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        return alert
    }
    
    static func showAlertWithAction(title: String, message: String, cancelFunc: Bool? = false, doneAction: UIAlertAction) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelFunc == true {
            alert.addAction(UIAlertAction(title: "취소", style: .destructive))
        }
        alert.addAction(doneAction)
        
        return alert
    }
    
    static func showActionSheet(title: String, message: String, actionArr: [String]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for i in actionArr {
            alert.addAction(UIAlertAction(title: i, style: .default))
        }
        
        return alert
    }
    
}
