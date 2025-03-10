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
    
    func dateFormatOnTrendingView(strDate: String, format: String, isCoinDetailDate: Bool = false) -> String {
        let inputDate = DateFormatter()
        
        inputDate.dateFormat = isCoinDetailDate ?
         "yyyy-MM-dd'T'HH:mm:ss.SSSZ" : "EEE, dd MMM yyyy HH:mm:ss zzz"
        let date = inputDate.date(from: strDate)
        
        let outputDate = DateFormatter()
        outputDate.dateFormat = format
        outputDate.timeZone = TimeZone(identifier: "Asia/Seoul") //GMT를 한국시간으로 변경
        guard let date else {
            print("setDateString error")
            return ""
        }
        
        if isCoinDetailDate {
            //. 기준으로 배열 원소 나누기
            let dateComponents = outputDate.string(from: date).split(separator: ".")
            if dateComponents.count == 3 {
                let year = dateComponents[0]
                let month = dateComponents[1]
                let day = dateComponents[2]
                return "\(year)년 \(month)월 \(day)일"
            }
        }
        
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
