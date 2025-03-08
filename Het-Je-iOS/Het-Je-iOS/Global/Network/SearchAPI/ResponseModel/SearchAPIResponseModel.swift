//
//  SearchAPIResponseModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

extension DTO.Response.Search {

    struct SearchAPIResponseModel: Codable {
        let coins: [Coin]
    }

    struct Coin: Codable {
        let id, name, symbol: String
        let marketCapRank: Int
        let thumb: String

        enum CodingKeys: String, CodingKey {
            case id, name, symbol
            case marketCapRank = "market_cap_rank"
            case thumb
        }
    }
    
}
