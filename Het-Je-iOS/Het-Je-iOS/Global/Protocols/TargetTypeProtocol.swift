//
//  TargetTypeProtocol.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import Foundation

import Alamofire

protocol TargetTypeProtocol: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders { get }
    var utilPath: String { get }
    var path: String { get }
    var parameters: RequestParams? { get }
    var encoding: ParameterEncoding { get }
}

enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
}

extension TargetTypeProtocol {
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(utilPath + path)
        var urlRequest = try URLRequest(url: url, method: method)
        urlRequest.headers = header

        switch parameters {
        case let .query(request):
            let params = request?.toDictionary() ?? [:]
            return try encoding.encode(urlRequest, with: params)
        case let .body(request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            return try encoding.encode(urlRequest, with: nil)
        case .none:
            return urlRequest
        }
    }
    
}

extension Encodable {
    
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
    
}
