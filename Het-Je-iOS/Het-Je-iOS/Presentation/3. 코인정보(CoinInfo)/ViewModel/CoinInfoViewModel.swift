//
//  CoinInfoViewModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import Foundation

import RxCocoa
import RxSwift

final class CoinInfoViewModel: ViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    private let onCallAPI = Observable<Int>.interval(.seconds(600), scheduler: MainScheduler.instance)
    private let list = PublishSubject<DTO.Response.TrendingAPIResponseModel>()
    private var currentTime = ""
    private var currentSearchText = ""
    private let onError = BehaviorRelay<Int>(value: 0)
    
    struct Input {
        let searchText: ControlProperty<String>
        let tapSearchTextFieldReturnKey: ControlEvent<()>
        let in_PopularSearchCollectionViewTapped: ControlEvent<DTO.Response.Coin>
    }
    
    struct Output {
        let currentTitme: Driver<String>
        let sortedPopularSearchList: Driver<[DTO.Response.Coin]>
        let sortedPopularNFTList: Driver<[DTO.Response.Nft]>
        let validSearchText: PublishSubject<String>
        let out_PopularSearchCollectionViewTapped: Observable<ControlEvent<DTO.Response.Coin>.Element>
        let out_onError: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        print(#function)
        let currentTitme = BehaviorRelay(value: "")
        let originPopularSearchList = BehaviorSubject<[DTO.Response.Coin]>(value: [])
        let originPopularNFTList = BehaviorSubject<[DTO.Response.Nft]>(value: [])
        let isAPILoaded = BehaviorSubject<Bool>(value: false)
        let currentSearchText = PublishSubject<String>()
        
        onCallAPI
            .startWith(0)
            .debug("onCallAPI")
            .subscribe(with: self) { owner, _ in
                print("API 호출")
                owner.callTrendingAPI()
            }
            .disposed(by: disposeBag)

        list
            .subscribe(with: self) { owner, model in
                let dropSearchList = Array(model.coins.prefix(14))
                let droNFTList = Array(model.nfts.prefix(7))
                originPopularSearchList.onNext(dropSearchList)
                originPopularNFTList.onNext(droNFTList)
                currentTitme.accept(owner.currentTime)
                isAPILoaded.onNext(true)
            }.disposed(by: disposeBag)
        
        let currentTitmeResult = Observable
            .combineLatest(currentTitme, isAPILoaded)
            .filter { _, loaded in loaded }
            .map { currentTitme, _ in
                print(currentTitme, "1111111")
                return currentTitme }
            .asDriver(onErrorJustReturn: "22")
            
        let sortedPopularSearchList = Observable
            .combineLatest(originPopularSearchList, isAPILoaded)
            .filter { _, loaded in loaded }
            .compactMap { list, _ in list }
            .asDriver(onErrorJustReturn: [])
        
        let sortedPopularNFTList = Observable
            .combineLatest(originPopularNFTList, isAPILoaded)
            .filter { _, loaded in loaded }
            .compactMap { list, _ in list }
            .asDriver(onErrorJustReturn: [])
        
        input.searchText
            .subscribe(with: self) { owner, text in
                owner.isValidSearchText(text: text)
            }.disposed(by: disposeBag)
        
        input.tapSearchTextFieldReturnKey
            .subscribe(with: self) { owner, _ in
                currentSearchText.onNext(owner.currentSearchText)
            }.disposed(by: disposeBag)
        
        return Output(
            currentTitme: currentTitmeResult,
            sortedPopularSearchList: sortedPopularSearchList,
            sortedPopularNFTList: sortedPopularNFTList,
            validSearchText: currentSearchText,
            out_PopularSearchCollectionViewTapped: input.in_PopularSearchCollectionViewTapped
                .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance),
            out_onError: onError.asDriver()
            )
        
    }
    
}

private extension CoinInfoViewModel {
    
    func callTrendingAPI() {
        print(#function)
        NetworkManager.shared.callAPI(apiHandler: .fetchTrendingAPI, responseModel: DTO.Response.TrendingAPIResponseModel.self) { [weak self] result, callDate, statusCode in
            guard let self else { return }
            self.onError.accept(statusCode)
            switch result {
            case .success(let success):
                let currentTime = CustomFormatterManager.shard.dateFormatOnTrendingView(strDate: callDate ?? "", format: "MM:dd HH:mm")
                self.currentTime = currentTime
                self.list.onNext(success)
            case .failure(let failure):
                print("Error callUpbitAPI: \(failure.localizedDescription)")
            }
        }
    }
    
    func isValidSearchText(text: String) {
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            currentSearchText = text
        } else {
            currentSearchText = ""
        }
    }
    
}

