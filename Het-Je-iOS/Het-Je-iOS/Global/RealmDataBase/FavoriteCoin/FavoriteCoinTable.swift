//
//  FavoriteCoinTable.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import Foundation

import RealmSwift
import RealmSwift

final class FavoriteCoinTable: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId //PK
    @Persisted var coinId: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var marketCapRank: Int
    @Persisted var thumb: String
    @Persisted var large: String
    
    convenience init(id: ObjectId,
                     coinId: String,
                     name: String,
                     symbol: String,
                     marketCapRank: Int,
                     thumb: String,
                     large: String)
    {
        self.init()
        self.id = id
        self.coinId = coinId
        self.name = name
        self.symbol = symbol
        self.marketCapRank = marketCapRank
        self.thumb = thumb
        self.large = large
    }
}
