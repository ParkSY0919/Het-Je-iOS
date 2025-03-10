//
//  CoinDetailViewModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import Foundation

import RealmSwift
import RxCocoa
import RxSwift

final class CoinDetailViewModel: ViewModelProtocol {
    
    let coinData: CoinInfo
    
    init(coinData: CoinInfo) {
        self.coinData = coinData
        print("coinInfoData: \(coinData)")
    }
    
    struct Input {
        let in_TapNavLeftBtn: ControlEvent<()>?
    }
    
    struct Output {
        let out_TapNavLeftBtn: Driver<Void>?
    }
    
    func transform(input: Input) -> Output {
        
        return Output(
            out_TapNavLeftBtn: input.in_TapNavLeftBtn?.asDriver()
        )
    }
    
}
