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
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let selectedButton: Observable<SortButtonComponent>
    }
    
    struct Output {
        let sortedListResult: Driver<[MarketData]>
    }
    
    func transform(input: Input) -> Output {
        let originList = BehaviorSubject(value: mockMarketData)
        
        let sortedList = input.selectedButton
            .withLatestFrom(originList) { selectedButton, data in
                self.sortListOfType(selectedButton: selectedButton, data: data)
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(sortedListResult: sortedList)
    }
}

private extension ExchangeViewModel {
    
    func sortListOfType(selectedButton: SortButtonComponent, data: [MarketData]) -> [MarketData] {
        let sortBy = selectedButton.currentState
        let sortClosure: (MarketData, MarketData) -> Bool

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
