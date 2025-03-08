//
//  ExchangeViewModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/8/25.
//

import Foundation

import RxCocoa
import RxSwift

final class ExchangeViewModel: ViewModelProtocol {
    //현재 눌려있는 버튼
    var activeSortButton: SortButtonComponent?
    private let onCallAPI = Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance)
    private let list = PublishSubject<[DTO.Response.MarketData]>()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let selectedButton: Observable<SortButtonComponent>
    }
    
    struct Output {
        let sortedListResult: Driver<[DTO.Response.MarketData]>
    }
    
    func transform(input: Input) -> Output {
        let originList = BehaviorSubject<[DTO.Response.MarketData]>(value: [])
        let isAPILoaded = BehaviorSubject<Bool>(value: false) //초기 api 로드 여부

        onCallAPI
            .startWith(0)
            .subscribe(with: self) { owner, _ in
                owner.callUpbitAPI()
            }
            .disposed(by: disposeBag)

        
        list.subscribe(with: self) { owner, model in
            originList.onNext(model)
            isAPILoaded.onNext(true) //api 통신 끝났음을 알림
        }.disposed(by: disposeBag)

        //combineLatest 사용하여 api 로드 끝나면 아래 코드가 진행되도록 핸들링
            //-> combineLatest은 해당되는 이벤트들이 한번씩은 발동해야 동작하기 때문
        let sortedList = Observable
            .combineLatest(input.selectedButton, originList, isAPILoaded)
            .filter { _, _, loaded in loaded }
            .compactMap { selectedButton, data, _ in
                self.sortListOfType(selectedButton: selectedButton, data: data)
            }
            .asDriver(onErrorJustReturn: [])

        return Output(sortedListResult: sortedList)
    }
}

private extension ExchangeViewModel {
    
    func callUpbitAPI() {
        let request = DTO.Request.UpbitAPIRequestModel(quote_currencies: StringLiterals.koreaCurrency)
        NetworkManager.shared.callAPI(apiHandler: .fetchUpbitAPI(request: request), responseModel: [DTO.Response.MarketData].self) { result in
            switch result {
            case .success(let success):
                self.list.onNext(success)
            case .failure(let failure):
                print("Error callUpbitAPI: \(failure.localizedDescription)")
            }
        }
    }
    
    func sortListOfType(selectedButton: SortButtonComponent, data: [DTO.Response.MarketData]) -> [DTO.Response.MarketData] {
        let sortBy = selectedButton.currentState
        let sortClosure: (DTO.Response.MarketData, DTO.Response.MarketData) -> Bool

        //정렬기준 none이라면 거래대금 내림차순으로 반환
        if sortBy == .none {
            return data.sorted { $0.accTradePrice24h > $1.accTradePrice24h }
        }

        switch selectedButton.type {
        case .currentPrice:
            sortClosure = (sortBy == .ascending) ?
            { $0.tradePrice < $1.tradePrice } : { $0.tradePrice > $1.tradePrice }
        case .prevDay:
            sortClosure = (sortBy == .ascending) ?
            { $0.signedChangeRate < $1.signedChangeRate } : { $0.signedChangeRate > $1.signedChangeRate }
        case .tradePayout:
            sortClosure = (sortBy == .ascending) ?
            { $0.accTradePrice24h < $1.accTradePrice24h } : { $0.accTradePrice24h > $1.accTradePrice24h }
        }

        return data.sorted(by: sortClosure)
    }
    
}
