//
//  NetworkManager.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import Foundation

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callAPI<T: Decodable>(apiHandler: TargetType,
                                          responseModel: T.Type,
                                          completionHandler: @escaping (Result<T, AFError>) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let result):
                    print("✅ API 요청 성공")
                    completionHandler(.success(result))
                case .failure(let error):
                    print("❌ API 요청 실패\n", error)
                    completionHandler(.failure(error))
                }
            }
    }
    
    func callAPI<T: Decodable>(apiHandler: TargetType,
                                          responseModel: T.Type,
                               completionHandler: @escaping (Result<T, AFError>, String?) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let result):
                    print("✅ API 요청 성공")
                    completionHandler(.success(result), response.response?.headers.dictionary["Date"])
                case .failure(let error):
                    print("❌ API 요청 실패\n", error)
                    completionHandler(.failure(error), response.response?.headers.dictionary["Date"])
                }
            }
    }
    
}



