//
//  TargetType.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//
import Foundation

import Alamofire

enum TargetType {
    case fetchUpbitAPI(request: DTO.Request.UpbitAPIRequestModel)
}

extension TargetType: TargetTypeProtocol {
    
    var baseURL: URL {
        switch self {
        case .fetchUpbitAPI:
            guard let urlString = Bundle.main.object(forInfoDictionaryKey: Config.Keys.upbitURL) as? String,
                  let url = URL(string: urlString) else {
                fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
            }
            return url
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var utilPath: String {
        switch self {
        case .fetchUpbitAPI:
            return ""
        }
    }
    
    var path: String {
        return ""
    }
    
    var parameters: RequestParams? {
        switch self {
        case .fetchUpbitAPI(let request):
            return .query(request)
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    var header: Alamofire.HTTPHeaders {
        guard let coingeckoAPIKey = Bundle.main.object(forInfoDictionaryKey: Config.Keys.coinGeckoAPI) as? String
        else {
            fatalError("🚨api key를 찾을 수 없습니다🚨")
        }
        switch self {
        case .fetchUpbitAPI:
            let header: HTTPHeaders = [
                    .init(name: "Content-Type", value: "application/json"),
                    .init(name: "Accept", value: "application/json")
                ]
            return header
        default:
            let header: HTTPHeaders = [
                    .init(name: "Content-Type", value: "application/json"),
                    .init(name: "Accept", value: "application/json"),
                    .init(name: "Authorization", value: "Bearer " + coingeckoAPIKey)
                ]
            return header
        }
    }
    
}
