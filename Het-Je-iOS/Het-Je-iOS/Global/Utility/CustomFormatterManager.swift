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
    
    func formatNum(num: Double, isTradePrice: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        let formatted = formatter.string(from: NSNumber(value: num)) ?? "formatNum fail"
        
        //isTradePrice == true, .(소수점) 있으면서, 접미사 0인지 조건부 처리
        if isTradePrice, let decimalIndex = formatted.firstIndex(of: ".") {
            //접미사 "0"인지
            if formatted.hasSuffix("0") {
                //소수점과 그 다음 숫자까지만 남기고 자름
                  //after: 주어진 index 바로 뒤까지 반환
                let trimmed = String(formatted.prefix(upTo: formatted.index(after: decimalIndex)))
                return trimmed
            }
        }
        return formatted
    }


    func formatAddTradePrice(num: Double) -> String {
        let million = 1000000.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        if num >= million {
            let formattedValue = formatter.string(from: NSNumber(value: num / million)) ?? "0"
            return "\(formattedValue)백만"
        } else {
            return formatter.string(from: NSNumber(value: num)) ?? "0"
        }
    }
    
}
