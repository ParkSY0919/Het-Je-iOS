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

enum CoinGekoErrorCode: Int, CaseIterable {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case tooManyRequests = 429
    case serviceUnavailable = 503
    case accessDenied = 1020
    case apiKeyMissing = 10002
    case endpointError = 10005
    //인터넷 에러는 네트워크 단절대응 했기에 생략
    
    var message: String {
        switch self {
        case .badRequest:
            StringLiterals.CoinGekoErrorMessages.badRequest
        case .unauthorized:
            StringLiterals.CoinGekoErrorMessages.unauthorized
        case .forbidden:
            StringLiterals.CoinGekoErrorMessages.forbidden
        case .tooManyRequests:
            StringLiterals.CoinGekoErrorMessages.tooManyRequests
        case .serviceUnavailable:
            StringLiterals.CoinGekoErrorMessages.serviceUnavailable
        case .accessDenied:
            StringLiterals.CoinGekoErrorMessages.accessDenied
        case .apiKeyMissing:
            StringLiterals.CoinGekoErrorMessages.apiKeyMissing
        case .endpointError:
            StringLiterals.CoinGekoErrorMessages.endpointError
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
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
    
    func callAPI<T: Decodable>(apiHandler: TargetType,
                               responseModel: T.Type,
                               completionHandler: @escaping (Result<T, AFError>, String?, Int) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in

                let statusCode = response.response?.statusCode ?? -1
                let date = response.response?.headers.dictionary["Date"]
                switch response.result {
                case .success(let result):
                    print("✅ API 요청 성공")
                    completionHandler(.success(result), date, statusCode)
                case .failure(let error):
                    print("❌ API 요청 실패\n", error)
                    completionHandler(.failure(error), date, statusCode)
                }
            }
    }
    
    func callAPI<T: Decodable>(apiHandler: TargetType,
                               responseModel: T.Type,
                               completionHandler: @escaping (Result<T, AFError>, Int) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                let statusCode = response.response?.statusCode ?? -1
                print("현재 statusCode: \(statusCode)")
                switch response.result {
                case .success(let result):
                    print("✅ API 요청 성공")
                    completionHandler(.success(result), statusCode)
                case .failure(let error):
                    print("❌ API 요청 실패\n", error)
                    completionHandler(.failure(error), statusCode)
                }
            }
    }
    
}




//                debugPrint(response.response?.headers.dictionary["Body"] ?? "body error")
                    //error 발생 시 body는 10bytes 와 같이 나오고 위와 같이 접근하니 'body error'만 출력되어 statusCode를 활용
