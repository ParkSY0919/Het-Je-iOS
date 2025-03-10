//
//  TrendingAPIResponseModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

extension DTO.Response {
    
    struct TrendingAPIResponseModel: Codable {
        let coins: [Coin]
        let nfts: [Nft]
    }
    
    struct Coin: Codable {
        let item: TrendingCoinDetails
    }
    
    struct TrendingCoinDetails: Codable {
        let id: String
        let name, symbol: String
        let score: Int
        let thumb, small, large: String
        let data: TrendingCoinData
        
        enum CodingKeys: String, CodingKey {
            case id, name, symbol, score
            case thumb, small, large
            case data
        }
    }
    
    struct TrendingCoinData: Codable {
        let priceChangePercentage24H: [String: Double]
        let doublePriceChangePercentage24H: Double
        
        enum CodingKeys: String, CodingKey {
            case priceChangePercentage24H = "price_change_percentage_24h"
        }
        
        //커스텀 디코딩 출동
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            let priceDict = try container.decodeIfPresent([String: Double].self, forKey: .priceChangePercentage24H) ?? [:]
            //priceChangePercentage24H 초기화
            self.priceChangePercentage24H = priceDict
            
            //doublePriceChangePercentage24H 초기화
            if let krwValue = priceDict["krw"] {
                self.doublePriceChangePercentage24H = krwValue
            } else {
                self.doublePriceChangePercentage24H = 88.88
            }
        }
    }
    
    struct Nft: Codable {
        let name, symbol: String
        let thumb: String
        let nativeCurrencySymbol: String
        let floorPriceInNativeCurrency: Double
        let floorPrice24HPercentageChange: Double
        let data: TrendingNFTData
        
        enum CodingKeys: String, CodingKey {
            case name, symbol, thumb
            case nativeCurrencySymbol = "native_currency_symbol"
            case floorPriceInNativeCurrency = "floor_price_in_native_currency"
            case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
            case data
        }
    }
    
    struct TrendingNFTData: Codable {
        let floorPriceInUsd24HPercentageChange: String
        
        enum CodingKeys: String, CodingKey {
            case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        }
    }
        
}
