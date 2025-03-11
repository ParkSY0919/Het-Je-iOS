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
            "잘못된 요청입니다. 입력값을 확인해주세요."
        case .unauthorized:
            "인증되지 않은 요청입니다. 다시 로그인해주세요"
        case .forbidden:
            "접근이 차단되었습니다. 권한을 확인해주세요."
        case .tooManyRequests:
            "요청이 너무 많습니다. 잠시 후 다시 시도해주세요."
        case .serviceUnavailable:
            "현재 서비스 이용이 어렵습니다. 잠시 후 다시 시도해주세요."
        case .accessDenied:
            "접근이 제한되었습니다. 관리자에게 문의해주세요."
        case .apiKeyMissing:
            "API 키가 잘못되었습니다. 설정을 확인해주세요."
        case .endpointError:
            "해당 요청은 제한된 기능입니다. 구독을 확인해주세요."
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
                               completionHandler: @escaping (Result<T, AFError>, String?, Int?) -> Void) {
        AF.request(apiHandler)
            .responseDecodable(of: T.self) { response in

                let statusCode = response.response?.statusCode
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
