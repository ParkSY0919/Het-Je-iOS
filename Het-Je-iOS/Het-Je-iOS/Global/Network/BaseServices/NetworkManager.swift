//
//  NetworkManager.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import Foundation

import Alamofire

enum UpbitAPIError<C: Decodable>: Error {
    case serverError(C)
    case networkError(AFError)
}

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
    
    //Upbit api 호출
    func callAPI<T: Decodable, C: Decodable>(apiHandler: TargetType,
                                             responseModel: T.Type,
                                             errorResponseModel: C.Type,
                                             completionHandler: @escaping (Result<T, UpbitAPIError<C>>) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let result):
                    print("✅ API 요청 성공")
                    completionHandler(.success(result))
                case .failure(let error):
                    print("❌ API 요청 실패\n", error)
                    
                    if let data = response.data {
                        do {
                            //errorModel에 맞게 디코딩
                            let decodedError = try JSONDecoder().decode(C.self, from: data)
                            completionHandler(.failure(.serverError(decodedError)))
                            return
                        } catch {
                            print("에러 응답 디코딩 실패: \(error)")
                        }
                    }
                    completionHandler(.failure(.networkError(error)))
                }
            }
    }
    
}



