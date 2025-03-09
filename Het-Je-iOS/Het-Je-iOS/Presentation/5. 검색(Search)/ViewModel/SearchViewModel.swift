//
//  SearchViewModel.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/9/25.
//

import Foundation

import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelProtocol {
    
    struct Input {
        let in_TapNavBackButton: ControlEvent<Void>
    }
    
    struct Output {
        let out_TapNavBackButton: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let out_TapNavBackButton = input.in_TapNavBackButton
            .asDriver()
        
        
        return Output(out_TapNavBackButton: out_TapNavBackButton)
    }
    
}
