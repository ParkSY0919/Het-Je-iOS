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
    
    enum NetworkGuidance {
        static let statusLabelText = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        static let retryBtnTitle = "다시 시도하기"
        static let toastMessage = "네트워크 통신이 원활하지 않습니다."
    }
    
    enum Exchange {
        static let marketTitle = "코인"
        static let currentPrice = "현재가"
        static let prevDay = "전일대비"
        static let tradePayout = "거래대금"
    }
    
    enum CoinInfo {
        static let navTitle = "가상자산 / 심볼 검색"
        static let popularSearchLabel = "인기 검색어"
        static let popularNFTLabel = "인기 NFT"
        static let searchTextFieldPlaceHolder = "검색어를 입력해주세요."
    }
    
    enum CoinDetail {
        static let headerTitle1 = "종목정보"
        static let headerTitle2 = "투자지표"
        
        static let high24hLabel = "24시간 고가"
        static let low24hLabel = "24시간 저가"
        static let athLabel = "역대 최고가"
        static let atlLabel = "역대 최저가"
        
        static let marketCapLabel = "시가총액"
        static let fullyDilutedValuationLabel = "완전 희석 가치(FDV)"
        static let totalVolumeLabel = "총 거래량"
    }
    
    enum UpbitErrorMessages {
        static let badRequest = "요청을 처리할 수 없습니다. 잠시 후 다시 시도해주세요."
        static let unauthorized = "인증되지 않아 접근할 수 없는 요청입니다."
    }
    
    enum CoinGekoErrorMessages {
        static let badRequest = "잘못된 요청입니다. 입력값을 확인해주세요."
        static let unauthorized = "인증되지 않은 요청입니다. 다시 로그인해주세요"
        static let forbidden = "접근이 차단되었습니다. 권한을 확인해주세요."
        static let tooManyRequests = "요청이 너무 많습니다. 잠시 후 다시 시도해주세요."
        static let serviceUnavailable = "현재 서비스 이용이 어렵습니다. 잠시 후 다시 시도해주세요."
        static let accessDenied = "접근이 제한되었습니다. 관리자에게 문의해주세요."
        static let apiKeyMissing = "API 키가 잘못되었습니다. 설정을 확인해주세요."
        static let endpointError = "해당 요청은 제한된 기능입니다. 구독을 확인해주세요."
    }
}
