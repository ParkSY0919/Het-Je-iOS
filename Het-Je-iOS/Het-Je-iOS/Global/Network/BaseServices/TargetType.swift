//
//  TargetType.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//
import Foundation

import Alamofire

enum TargetType {
}

extension TargetType: TargetTypeProtocol {
    
    var baseURL: URL {
        switch self {
            
        default:
            guard let urlString = Bundle.main.object(forInfoDictionaryKey: Config.Keys.baseURL) as? String,
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
        default:
            ""
        }
    }
    
    var path: String {
        return ""
    }
    
    var parameters: RequestParams? {
        switch self {
        default:
                .none
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    var header: Alamofire.HTTPHeaders {
        switch self {
        default:
            return HTTPHeaders()
        }
    }
    
}
