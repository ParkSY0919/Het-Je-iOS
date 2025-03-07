//
//  CustomFormatterManager.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import Foundation

final class CustomFormatterManager {
    
    static let shard = CustomFormatterManager()
    
    private init() {}
    
    func setDateString(strDate: String, format: String) -> String {
        let inputDate = DateFormatter()
        inputDate.dateFormat = "yyyy-MM-dd"
        let date = inputDate.date(from: strDate)
        
        let outputDate = DateFormatter()
        outputDate.dateFormat = format
        guard let date else {
            print("setDateString error")
            return ""
        }
        return outputDate.string(from: date)
    }
    
    func setDateStringFromDate(date: Date, format: String) -> String {
        let outputDate = DateFormatter()
        outputDate.dateFormat = format
        
        return outputDate.string(from: date)
    }
    
    func formatNum(num: Double) -> String {
        //정수라면
        if num.truncatingRemainder(dividingBy: 1) == 0 {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: Int(num))) ?? "formatNum fail"
        } else {
            //소수라면
            return String(format: "%.2f", num)
        }
    }
    
}
