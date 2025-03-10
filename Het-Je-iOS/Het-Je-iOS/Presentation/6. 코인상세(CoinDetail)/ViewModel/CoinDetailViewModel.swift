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
    private let disposeBag = DisposeBag()
    var currentTime = ""
    
    private lazy var onLoadAPI = BehaviorRelay(value: coinData.coinId)
    
    //rx 적용이전 사용할 list
    var list: [DTO.Response.MarketAPIResponseModel] = []
    private let isAPILoaded = PublishSubject<Bool>()
    
    init(coinData: CoinInfo) {
        self.coinData = coinData
        print("coinInfoData: \(coinData)")
    }
    
    struct Input {
        let in_TapNavLeftBtn: ControlEvent<()>?
    }
    
    struct Output {
        let out_TapNavLeftBtn: Driver<Void>?
        let out_ReloadCollectionViewData: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        onLoadAPI
            .bind(with: self) { owner, coinId in
                owner.callMarketAPI(coinId: coinId)
            }.disposed(by: disposeBag)
        
        let out_ReloadCollectionViewData = isAPILoaded
            .asObservable()
        
        
        return Output(
            out_TapNavLeftBtn: input.in_TapNavLeftBtn?.asDriver(),
            out_ReloadCollectionViewData: out_ReloadCollectionViewData
        )
    }
    
}

private extension CoinDetailViewModel {
    
    func callMarketAPI(coinId: String) {
        let request = DTO.Request.MarketAPIRequestModel(vs_currency: StringLiterals.koreaCurrency, ids: coinId, sparkline: "true")
        NetworkManager.shared.callAPI(apiHandler: .fetchMarketAPI(request: request), responseModel: [DTO.Response.MarketAPIResponseModel].self) { result, callDate in
            switch result {
            case .success(let success):
                let currentTime = CustomFormatterManager.shard.dateFormatOnTrendingView(strDate: callDate ?? "", format: "M/dd HH:mm:ss")
                self.currentTime = currentTime + " 업데이트"
                
                self.list = success
                self.isAPILoaded.onNext(true)
            case .failure(let failure):
                print("Error callMarketAPI: \(failure.localizedDescription)")
            }
        }
    }
    
}
