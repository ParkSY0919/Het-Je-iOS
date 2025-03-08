//
//  서치데이터.swift
//  Dobong_Crypto
//
//  Created by Bran on 3/7/25.
//

import Foundation

/// #3. Crypto Search 화면
struct SearchCoin {
  let id: String
  let name: String
  let apiSymbol: String
  let symbol: String
  let marketCapRank: Int
  let thumb: String
  let large: String
}

struct SearchNFT {
  let id: String
  let name: String
  let symbol: String
  let thumb: String
}

let mockSearchCoin: [SearchCoin] = [
  // 오리지널 페페
  SearchCoin(
    id: "pepe",
    name: "Pepe",
    apiSymbol: "pepe",
    symbol: "PEPE",
    marketCapRank: 44,
    thumb: "https://coin-images.coingecko.com/coins/images/29850/thumb/pepe-token.jpeg",
    large: "https://coin-images.coingecko.com/coins/images/29850/large/pepe-token.jpeg"
  ),

  // 페페코인
  SearchCoin(
    id: "SearchCoin-2",
    name: "SearchCoin",
    apiSymbol: "SearchCoin-2",
    symbol: "SearchCoin",
    marketCapRank: 588,
    thumb: "https://coin-images.coingecko.com/coins/images/30219/thumb/SearchCoin-icon_200x200.png",
    large: "https://coin-images.coingecko.com/coins/images/30219/large/SearchCoin-icon_200x200.png"
  ),

  // 페페 언체인드
  SearchCoin(
    id: "pepe-unchained",
    name: "Pepe Unchained",
    apiSymbol: "pepe-unchained",
    symbol: "PEPU",
    marketCapRank: 780,
    thumb: "https://coin-images.coingecko.com/coins/images/52681/thumb/wn6wNj1C_400x400.jpg",
    large: "https://coin-images.coingecko.com/coins/images/52681/large/wn6wNj1C_400x400.jpg"
  ),

  // 페페코인 네트워크
  SearchCoin(
    id: "SearchCoin-network",
    name: "SearchCoin",
    apiSymbol: "SearchCoin-network",
    symbol: "PEP",
    marketCapRank: 1036,
    thumb: "https://coin-images.coingecko.com/coins/images/36520/thumb/SearchCoin_onWhite_IconOnly-RGB__Converted_200x200.png",
    large: "https://coin-images.coingecko.com/coins/images/36520/large/SearchCoin_onWhite_IconOnly-RGB__Converted_200x200.png"
  ),

  // 퍼플 페페
  SearchCoin(
    id: "purple-pepe",
    name: "PURPLE PEPE",
    apiSymbol: "purple-pepe",
    symbol: "PURPE",
    marketCapRank: 1096,
    thumb: "https://coin-images.coingecko.com/coins/images/38962/thumb/IMG_3953.jpeg",
    large: "https://coin-images.coingecko.com/coins/images/38962/large/IMG_3953.jpeg"
  ),

  // 베이스드 페페
  SearchCoin(
    id: "based-pepe",
    name: "Based Pepe",
    apiSymbol: "based-pepe",
    symbol: "PEPE",
    marketCapRank: 1105,
    thumb: "https://coin-images.coingecko.com/coins/images/39763/thumb/based_pepe_transparent.png",
    large: "https://coin-images.coingecko.com/coins/images/39763/large/based_pepe_transparent.png"
  ),

  // 페페포크
  SearchCoin(
    id: "pepefork",
    name: "PepeFork",
    apiSymbol: "pepefork",
    symbol: "PORK",
    marketCapRank: 1249,
    thumb: "https://coin-images.coingecko.com/coins/images/34913/thumb/pork.png",
    large: "https://coin-images.coingecko.com/coins/images/34913/large/pork.png"
  ),

  // 월스트릿 페페
  SearchCoin(
    id: "wall-street-pepe",
    name: "Wall Street Pepe",
    apiSymbol: "wall-street-pepe",
    symbol: "WEPE",
    marketCapRank: 1416,
    thumb: "https://coin-images.coingecko.com/coins/images/54457/thumb/Wepe_Logo_200x200.png",
    large: "https://coin-images.coingecko.com/coins/images/54457/large/Wepe_Logo_200x200.png"
  ),

  // 페페 2.0
  SearchCoin(
    id: "pepe-2-0",
    name: "Pepe 2.0",
    apiSymbol: "pepe-2-0",
    symbol: "PEPE2.0",
    marketCapRank: 1742,
    thumb: "https://coin-images.coingecko.com/coins/images/30853/thumb/PEPE_2.0.png",
    large: "https://coin-images.coingecko.com/coins/images/30853/large/PEPE_2.0.png"
  ),

  // 닥터페페 AI
  SearchCoin(
    id: "drpepe-ai",
    name: "DrPepe.ai",
    apiSymbol: "drpepe-ai",
    symbol: "BRYAN",
    marketCapRank: 2141,
    thumb: "https://coin-images.coingecko.com/coins/images/53026/thumb/DRPEPE_LOGO.png",
    large: "https://coin-images.coingecko.com/coins/images/53026/large/DRPEPE_LOGO.png"
  ),

  // 페페캣
  SearchCoin(
    id: "pepecat-2",
    name: "PEPECAT",
    apiSymbol: "pepecat-2",
    symbol: "PEPECAT",
    marketCapRank: 2406,
    thumb: "https://coin-images.coingecko.com/coins/images/52185/thumb/pepecat.png",
    large: "https://coin-images.coingecko.com/coins/images/52185/large/pepecat.png"
  ),

  // 아스트로페페X
  SearchCoin(
    id: "astropepex",
    name: "AstroPepeX",
    apiSymbol: "astropepex",
    symbol: "APX",
    marketCapRank: 2438,
    thumb: "https://coin-images.coingecko.com/coins/images/31839/thumb/astropepexcoingecko.png",
    large: "https://coin-images.coingecko.com/coins/images/31839/large/astropepexcoingecko.png"
  ),

  // 영 피지 AKA 페페
  SearchCoin(
    id: "young-peezy-aka-pepe",
    name: "Young Peezy AKA Pepe",
    apiSymbol: "young-peezy-aka-pepe",
    symbol: "PEEZY",
    marketCapRank: 2561,
    thumb: "https://coin-images.coingecko.com/coins/images/36649/thumb/PFP_CG_200x200.jpeg",
    large: "https://coin-images.coingecko.com/coins/images/36649/large/PFP_CG_200x200.jpeg"
  ),

  // 스컬 오브 페페 토큰
  SearchCoin(
    id: "skull-of-pepe-token",
    name: "Skull of Pepe Token",
    apiSymbol: "skull-of-pepe-token",
    symbol: "SKOP",
    marketCapRank: 2586,
    thumb: "https://coin-images.coingecko.com/coins/images/38342/thumb/skop.jpeg",
    large: "https://coin-images.coingecko.com/coins/images/38342/large/skop.jpeg"
  ),

  // 베이비 페페
  SearchCoin(
    id: "baby-pepe-3",
    name: "Baby Pepe",
    apiSymbol: "baby-pepe-3",
    symbol: "BABYPEPE",
    marketCapRank: 2937,
    thumb: "https://coin-images.coingecko.com/coins/images/38672/thumb/NEW_BABYPEPE_LOGO.jpg",
    large: "https://coin-images.coingecko.com/coins/images/38672/large/NEW_BABYPEPE_LOGO.jpg"
  ),

  // 히스토리 오브 페페
  SearchCoin(
    id: "history-of-pepe",
    name: "History of Pepe",
    apiSymbol: "history-of-pepe",
    symbol: "HOPE",
    marketCapRank: 3371,
    thumb: "https://coin-images.coingecko.com/coins/images/38014/thumb/Hope1.png",
    large: "https://coin-images.coingecko.com/coins/images/38014/large/Hope1.png"
  ),

  // 페페 KRC20
  SearchCoin(
    id: "pepe-krc20",
    name: "Pepe KRC20",
    apiSymbol: "pepe-krc20",
    symbol: "$PEPE",
    marketCapRank: 3414,
    thumb: "https://coin-images.coingecko.com/coins/images/51131/thumb/PEPEKRC20XT.png",
    large: "https://coin-images.coingecko.com/coins/images/51131/large/PEPEKRC20XT.png"
  ),

  // 페페 (Ordinals)
  SearchCoin(
    id: "pepebrc",
    name: "PEPE (Ordinals)",
    apiSymbol: "pepebrc",
    symbol: "PEPE",
    marketCapRank: 3443,
    thumb: "https://coin-images.coingecko.com/coins/images/30225/thumb/pepe.png",
    large: "https://coin-images.coingecko.com/coins/images/30225/large/pepe.png"
  ),

  // 솔라나 기반 페페
  SearchCoin(
    id: "pepe-sol",
    name: "Pepe on SOL",
    apiSymbol: "pepe-sol",
    symbol: "PEPE",
    marketCapRank: 3545,
    thumb: "https://coin-images.coingecko.com/coins/images/38218/thumb/photo_5949643725443547660_m_%283%29.jpg",
    large: "https://coin-images.coingecko.com/coins/images/38218/large/photo_5949643725443547660_m_%283%29.jpg"
  ),

  // 페페 트럼프
  SearchCoin(
    id: "pepe-trump",
    name: "Pepe Trump",
    apiSymbol: "pepe-trump",
    symbol: "PTRUMP",
    marketCapRank: 3973,
    thumb: "https://coin-images.coingecko.com/coins/images/37560/thumb/Icon_2.png",
    large: "https://coin-images.coingecko.com/coins/images/37560/large/Icon_2.png"
  ),

  // 맥페페
  SearchCoin(
    id: "mcpepe-s",
    name: "McPepe's",
    apiSymbol: "mcpepe-s",
    symbol: "PEPES",
    marketCapRank: 4041,
    thumb: "https://coin-images.coingecko.com/coins/images/29265/thumb/pepes-logo_%282%29.png",
    large: "https://coin-images.coingecko.com/coins/images/29265/large/pepes-logo_%282%29.png"
  ),

  // 밈 월드의 페페
  SearchCoin(
    id: "pepe-in-a-memes-world",
    name: "pepe in a memes world",
    apiSymbol: "pepe-in-a-memes-world",
    symbol: "PEW",
    marketCapRank: 4232,
    thumb: "https://coin-images.coingecko.com/coins/images/38245/thumb/pew.jpeg",
    large: "https://coin-images.coingecko.com/coins/images/38245/large/pew.jpeg"
  ),
]

let mockSearchNFT: [SearchNFT] = [
  // 페페 펫 포비
  SearchNFT(
    id: "pepe-pet-poby",
    name: "PEPE PET POBY",
    symbol: "PPP",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/4598/thumb/pepe-pet-poby.png"
  ),

  // 매트 퓨리의 레어페페
  SearchNFT(
    id: "rarepepe-by-matt-furie",
    name: "RarePepe by Matt Furie",
    symbol: "MFRP",
    thumb: "missing_thumb.png"
  ),

  // 페페드라이브 II
  SearchNFT(
    id: "pepedrive-ii",
    name: "PepeDrive II",
    symbol: "PD2",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/15366/thumb/pepedrive-ii.png"
  ),

  // 페페
  SearchNFT(
    id: "pepe-pee-pee-redeployed",
    name: "Pepe",
    symbol: "PEPE",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/3192/thumb/pepe-pee-pee-redeployed.png"
  ),

  // 클레이 페페
  SearchNFT(
    id: "clay-pepes",
    name: "Clay Pepes",
    symbol: "CLAY-PEPES",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/3350/thumb/clay-pepes.jpg"
  ),

  // 페페 펑크
  SearchNFT(
    id: "pepe-punks",
    name: "Pepe Punks",
    symbol: "PEPEPUNKS",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/3833/thumb/pepe-punks.jpg"
  ),

  // 레어 에이프페 YC
  SearchNFT(
    id: "rareapepeyachtclub",
    name: "Rare Apepe YC",
    symbol: "RAYC",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/1296/thumb/unnamed.jpg"
  ),

  // 크립토페페 2018
  SearchNFT(
    id: "cryptopepes-2018",
    name: "CryptoPepes 2018",
    symbol: "CPEP",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/4270/thumb/cryptopepes-2018.png"
  ),

  // 스프로토 페페
  SearchNFT(
    id: "sproto-pepes",
    name: "Sproto Pepes",
    symbol: "SP",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/3426/thumb/sproto-pepes.png"
  ),

  // 오피펜 에디션
  SearchNFT(
    id: "opepen-edition",
    name: "Opepen Edition",
    symbol: "OPEPEN",
    thumb: "https://coin-images.coingecko.com/nft_contracts/images/2540/thumb/opepen.jpeg"
  )
]
