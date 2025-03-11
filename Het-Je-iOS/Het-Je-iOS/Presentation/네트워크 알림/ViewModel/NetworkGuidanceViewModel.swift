//
//  NetworkGuidanceViewModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import Foundation

import RxCocoa
import RxSwift

final class NetworkGuidanceViewModel: ViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let in_retryButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let out_retryButtonTapped: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(
            out_retryButtonTapped: input.in_retryButtonTapped.asObservable()
        )
    }
    
}
