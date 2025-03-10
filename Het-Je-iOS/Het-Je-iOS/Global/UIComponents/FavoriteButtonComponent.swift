//
//  FavoriteButtonComponent.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import UIKit

import RealmSwift
import SnapKit
import Then

final class FavoriteButtonComponent: UIButton {
    
    private let favoriteRepository: FavoriteCoinRepositoryProtocol = FavoriteCoinRepository()
    private var coinInfo: CoinInfo?
    var onChange: ((Bool)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setFavoriteButtonStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteButtonStyle() {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(resource: .primary)
        config.baseBackgroundColor = .clear
        self.configuration = config
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.image = AppIconType.star.image
            case .selected:
                button.configuration?.image = AppIconType.star_fill.image
            default:
                return
            }
        }
        self.configurationUpdateHandler = buttonStateHandler
        
        self.addTarget(self,
                       action: #selector(favoriteButtonTapped),
                       for: .touchUpInside)
    }
    
    func fetchFavoriteBtn(coinInfo: DTO.Response.Search.Coin) {
        let coinInfo = CoinInfo(coinId: coinInfo.id,
                                name: coinInfo.name,
                                symbol: coinInfo.symbol,
                                marketCapRank: coinInfo.marketCapRank,
                                thumb: coinInfo.thumb,
                                large: coinInfo.large)
        
        self.coinInfo = coinInfo
        self.isSelected = isFavoriteCoin(coinInfo: coinInfo)
    }
    
    //코인상세 or 검색 화면에서 사용할 함수
    //-> 이전화면에서 CoinInfo형태 코인관련 data를 넘겨줄 거라 타입을 아래와 같이 설정
    func fetchFavoriteBtn(coinInfo: CoinInfo) {
        self.coinInfo = coinInfo
        self.isSelected = isFavoriteCoin(coinInfo: coinInfo)
    }
    
    private func isFavoriteCoin(coinInfo: CoinInfo) -> Bool {
        let favoriteCoinList = favoriteRepository.fetchAll()
        return favoriteRepository.checkFavoriteCoin(list: favoriteCoinList, currentCoinId: coinInfo.coinId)
    }
    
    @objc
    private func favoriteButtonTapped() {
        self.isUserInteractionEnabled = false
        
        guard let coinInfo = self.coinInfo else {
            print("코인 정보가 없습니다.")
            return
        }
        self.isSelected.toggle()
        switch self.isSelected {
        case true:
            createFavoriteCoin(coinInfo: coinInfo)
        case false:
            print(#function, "delete table")
            deleteFavoriteCoin(coinInfo: coinInfo)
        }
    }
    
    private func createFavoriteCoin(coinInfo: CoinInfo) {
        let data = FavoriteCoinTable(coinId: coinInfo.coinId,
                                     name: coinInfo.name,
                                     symbol: coinInfo.symbol,
                                     marketCapRank: coinInfo.marketCapRank,
                                     thumb: coinInfo.thumb,
                                     large: coinInfo.large)
        favoriteRepository.getFileURL()
        favoriteRepository.createItem(data: data)
        self.isUserInteractionEnabled = true
    }
    
    private func deleteFavoriteCoin(coinInfo: CoinInfo) {
        let favoriteCoinList = favoriteRepository.fetchAll()
        guard let data = favoriteRepository.getFavoriteCoinDataByCoinId(list: favoriteCoinList, currentCoinId: coinInfo.coinId) else {
            print("coinId와 맞는 table data를 불러오는데 실패하였습니다.")
            return
        }
        
        favoriteRepository.deleteItem(data: data)
        self.isUserInteractionEnabled = true
    }
    
}

