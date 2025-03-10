//
//  SearchViewModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import Foundation

import RealmSwift
import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelProtocol {
    
    let navTitle: String
    let favoriteCoinList: Results<FavoriteCoinTable>
    private let disposeBag = DisposeBag()
    private lazy var callSearchAPI = BehaviorRelay(value: navTitle.uppercased())
    private let list = PublishRelay<[DTO.Response.Search.Coin]>()
    
    init(navTitle: String, list: Results<FavoriteCoinTable>) {
        self.navTitle = navTitle
        self.favoriteCoinList = list
    }
    
    struct Input {
        let in_TapNavBackButton: ControlEvent<Void>
        let in_TapNavTextFieldReturnKey: ControlEvent<()>
        let in_NavTextFieldText: ControlProperty<String>
        let in_SearchResultCellTapped: ControlEvent<DTO.Response.Search.Coin>
    }
    
    struct Output {
        let out_TapNavBackButton: Driver<Void>
        let out_SearchResultList: Driver<[DTO.Response.Search.Coin]>
        let out_IsScrollToTop: PublishRelay<Bool>
        let in_SearchResultCellTapped: Observable<ControlEvent<DTO.Response.Search.Coin>.Element>
    }
    
    func transform(input: Input) -> Output {
        let out_TapNavBackButton = input.in_TapNavBackButton
            .asDriver()
        let originSearchResultList = PublishRelay<[DTO.Response.Search.Coin]>()
        let isAPILoaded = PublishSubject<Bool>()
        let out_IsScrollToTop = PublishRelay<Bool>()
        
        callSearchAPI
            .distinctUntilChanged() //중복 검색어 호출 방지
            .bind(with: self) { owner, text in
                print("api 호출: \(text)")
                owner.callSearchAPI(text: text)
                out_IsScrollToTop.accept(true)
            }.disposed(by: disposeBag)
        
        list
            .subscribe(with: self) { owner, model in
                originSearchResultList.accept(model)
                isAPILoaded.onNext(true)
            }.disposed(by: disposeBag)
        
        input.in_TapNavTextFieldReturnKey
            .withLatestFrom(input.in_NavTextFieldText)
            .withUnretained(self)
            .compactMap { owner, text -> String? in
                return owner.isValidSearchText(text: text)?.uppercased()
            }
            .subscribe(with: self) { owner, searchText in
                
                owner.callSearchAPI.accept(searchText)
            }.disposed(by: disposeBag)
        
        let out_SearchResultList = Observable
            .combineLatest(originSearchResultList, isAPILoaded)
            .filter { _, loaded in loaded }
            .compactMap { item, _ in item }
            .asDriver(onErrorJustReturn: [])
        
        return Output(
            out_TapNavBackButton: out_TapNavBackButton,
            out_SearchResultList: out_SearchResultList,
            out_IsScrollToTop: out_IsScrollToTop, in_SearchResultCellTapped: input.in_SearchResultCellTapped
                .throttle(.seconds(3), latest: false, scheduler: MainScheduler.instance)
        )
    }
    
}

private extension SearchViewModel {
    
    func callSearchAPI(text: String) {
        let request = DTO.Request.SearchAPIRequestModel(query: text)
        NetworkManager.shared.callAPI(apiHandler: .fetchSearchAPI(request: request), responseModel: DTO.Response.Search.SearchAPIResponseModel.self) { result in
            switch result {
            case .success(let success):
                self.list.accept(success.coins)
            case .failure(let failure):
                print("Error callSearchAPI: \(String(describing: failure.errorDescription))")
            }
        }
    }
    
    func isValidSearchText(text: String) -> String? {
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return text
        } else {
            return nil
        }
    }
    
}
