//
//  Config.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import Foundation

enum Config {
    enum Keys {
        static let baseURL = "BASE_URL"
        static let upbitURL = "UPBIT_URL"
        static let coinGeckoAPI = "COINGECKO_API"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found !!!")
        }
        return dict
    }()
}


extension Config {
    
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.baseURL] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
    
    static let upbitURL: String = {
        guard let key = Config.infoDictionary[Keys.upbitURL] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
    
    static let coinGeckoAPI: String = {
        guard let key = Config.infoDictionary[Keys.coinGeckoAPI] as? String else {
            fatalError("BASE_URL is not set in plist for this configuration")
        }
        return key
    }()
    
}
