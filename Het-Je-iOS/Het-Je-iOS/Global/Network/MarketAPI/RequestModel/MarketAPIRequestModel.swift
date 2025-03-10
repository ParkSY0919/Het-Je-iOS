//
//  MarketAPIRequestModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

extension DTO.Request {
    
    struct MarketAPIRequestModel: Encodable {
        let vs_currency: String
        let ids: String
        let sparkline: Bool = true
    }
    
}
