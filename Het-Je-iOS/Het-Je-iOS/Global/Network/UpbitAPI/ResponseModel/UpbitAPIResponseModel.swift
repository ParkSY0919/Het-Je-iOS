//
//  UpbitAPIResponseModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//


extension DTO.Response {
    struct MarketData: Codable {
        let market: String
        let tradePrice: Double
        let signedChangePrice: Double
        let signedChangeRate: Double
        let accTradePrice24h: Double
        
        enum CodingKeys: String, CodingKey {
            case market
            case tradePrice = "trade_price"
            case signedChangePrice = "signed_change_price"
            case signedChangeRate = "signed_change_rate"
            case accTradePrice24h = "acc_trade_price_24h"
        }
    }
    
    struct UpbitAPIErrorResponseModel: Codable {
        let error: UpbitError
    
        struct UpbitError: Codable {
            let name: Int
            let message: String
        }
    }
    
}
