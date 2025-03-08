//
//  StringLiterals.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//


import Foundation

enum StringLiterals {}

extension StringLiterals {
    
    static let koreaCurrency = "KRW"
    
    enum TabBar {
        static let exchangeTitle = "거래소"
        static let coinInfoTitle = "코인정보"
        static let portfolioTitle = "포트폴리오"
    }
    
    enum Exchange {
        static let marketTitle = "코인"
        static let currentPrice = "현재가"
        static let prevDay = "전일대비"
        static let tradePayout = "거래대금"
    }
    
    enum CoinInfo {
        static let navTitle = "가상자산 / 심볼 검색"
    }
    
}
