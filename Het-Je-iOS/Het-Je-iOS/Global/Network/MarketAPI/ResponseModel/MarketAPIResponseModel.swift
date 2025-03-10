//
//  MarketAPIResponseModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

extension DTO.Response {
    
    struct CoinDetail: Decodable {
      let id: String//id
      let symbol: String//심볼명
      let currentPrice: Double//현재가
      let marketCap: Double//시가총액
      let marketCapRank: Int
      let fullyDilutedValuation: Double?//완전희석가치
      let totalVolume: Double//총 거래량
      let high24h: Double//24시간 최고가
      let low24h: Double//24시간 최저가
      let priceChangePercentage24h: Double?//24시간 변동률
      let ath: Double//역대 최고가
      let atl: Double//역대 최저가
        
        let atlDate, athDate: String
      let lastUpdated: String// 최근 업데이트 시간
      let sparklineIn7d: SparklineData //7일간 변화 그래프
        
        enum CodingKeys: String, CodingKey {
            case athDate = "ath_date"
            case atlDate = "atl_date"
            case id
            case symbol
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case marketCapRank = "market_cap_rank"
            case fullyDilutedValuation = "fully_diluted_valuation"
            case totalVolume = "total_volume"
            case high24h = "high_24h"
            case low24h = "low_24h"
            case priceChangePercentage24h = "price_change_percentage_24h"
            case ath
            case atl
            case lastUpdated = "last_updated"
            case sparklineIn7d = "sparkline_in_7d"
        }
    }
    
    struct SparklineData: Decodable {
      let price: [Double]
    }
    
}
