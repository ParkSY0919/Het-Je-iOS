//
//  ViewModelProtocol.swift
//  TamaGrow-iOS
//
//  Created by 박신영 on 2/22/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
