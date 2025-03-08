//
//  트렌딩데이터.swift
//  Dobong_Crypto
//
//  Created by Bran on 3/6/25.
//

import Foundation

/// #2. 트렌딩화면
struct TrendingCoinItem {
  let item: TrendingCoinDetails
}

struct TrendingCoinDetails {
  let id: String
  let coinId: Int
  let name: String
  let symbol: String
  let marketCapRank: Int
  let thumb: String
  let small: String
  let large: String
  let slug: String
  let priceBtc: Double
  let score: Int
  let data: TrendingCoinData
}

struct TrendingCoinData {
  let price: String
  let priceBtc: String
  let priceChangePercentage24h: [String: Double]
  let marketCap: String
  let marketCapBtc: String
  let totalVolume: String
  let totalVolumeBtc: String
  let sparkline: String
  let content: TrendingContentInfo?

}

struct TrendingContentInfo  {
  let title: String?
  let description: String?
}

struct TrendingNFTItem {
  let id: String
  let name: String
  let symbol: String
  let thumb: String
  let nftContractId: Int
  let nativeCurrencySymbol: String
  let floorPriceInNativeCurrency: Double
  let floorPrice24hPercentageChange: Double
  let data: TrendingNFTData
}

struct TrendingNFTData {
  let floorPrice: String
  let floorPriceInUsd24hPercentageChange: String
  let h24Volume: String
  let h24AverageSalePrice: String
  let sparkline: String
  let content: TrendingContentInfo?
}

struct TrendingCategoryItem {
  let id: Int
  let name: String
  let marketCap1hChange: Double
  let slug: String
  let coinsCount: Int
  let data: TrendingCategoryData
}

struct TrendingCategoryData {
  let marketCap: Double
  let marketCapBtc: Double
  let totalVolume: Double
  let totalVolumeBtc: Double
  let marketCapChangePercentage24h: [String: Double]
  let sparkline: String
}

let mockTrendingCoins: [TrendingCoinItem] = [
  // Pixels (PIXEL)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "pixels",
    coinId: 35100,
    name: "Pixels",
    symbol: "PIXEL",
    marketCapRank: 164,
    thumb: "https://assets.coingecko.com/coins/images/35100/thumb/pixel-icon.png?1708339519",
    small: "https://assets.coingecko.com/coins/images/35100/small/pixel-icon.png?1708339519",
    large: "https://assets.coingecko.com/coins/images/35100/large/pixel-icon.png?1708339519",
    slug: "pixels",
    priceBtc: 0.000011096372017795997,
    score: 0,
    data: TrendingCoinData(
      price: "$0.5743",
      priceBtc: "0.000011096372017796",
      priceChangePercentage24h: [
        "usd": 13.801022654320825,
        "btc": 14.926801240807364,
        "eth": 13.452002437792393,
        "krw": 13.976150617807855
      ],
      marketCap: "$439,280,817",
      marketCapBtc: "8491.70064930356",
      totalVolume: "$1,099,839,984",
      totalVolumeBtc: "21250.0362497114",
      sparkline: "https://www.coingecko.com/coins/35100/sparkline.svg",
      content: nil
    )
  )),

  // PaLM AI (PALM)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "palm-ai",
    coinId: 33097,
    name: "PaLM AI",
    symbol: "PALM",
    marketCapRank: 829,
    thumb: "https://assets.coingecko.com/coins/images/33097/thumb/PalmProfile01Artboard_6_2x.png?1703862864",
    small: "https://assets.coingecko.com/coins/images/33097/small/PalmProfile01Artboard_6_2x.png?1703862864",
    large: "https://assets.coingecko.com/coins/images/33097/large/PalmProfile01Artboard_6_2x.png?1703862864",
    slug: "palm-ai",
    priceBtc: 0.000007250308458224368,
    score: 1,
    data: TrendingCoinData(
      price: "$0.3753",
      priceBtc: "0.00000725030845822437",
      priceChangePercentage24h: [
        "usd": 33.567357835795384,
        "btc": 34.66658005363682,
        "eth": 32.38528440270579,
        "krw": 33.837073307182514
      ],
      marketCap: "$29,619,228",
      marketCapBtc: "572.595342774854",
      totalVolume: "$1,431,764",
      totalVolumeBtc: "27.6631504207441",
      sparkline: "https://www.coingecko.com/coins/33097/sparkline.svg",
      content: nil
    )
  )),

  // Crust Network (CRU)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "crust-network",
    coinId: 12549,
    name: "Crust Network",
    symbol: "CRU",
    marketCapRank: 585,
    thumb: "https://assets.coingecko.com/coins/images/12549/thumb/sAB3KVzD_400x400.jpg?1696512360",
    small: "https://assets.coingecko.com/coins/images/12549/small/sAB3KVzD_400x400.jpg?1696512360",
    large: "https://assets.coingecko.com/coins/images/12549/large/sAB3KVzD_400x400.jpg?1696512360",
    slug: "crust-network",
    priceBtc: 0.000037855128049886405,
    score: 2,
    data: TrendingCoinData(
      price: "$1.96",
      priceBtc: "0.0000378551280498864",
      priceChangePercentage24h: [
        "usd": 2.5507813136573465,
        "btc": 3.4318822181466806,
        "eth": 1.7299791170474061,
        "krw": 2.7437357385797774
      ],
      marketCap: "$57,844,489",
      marketCapBtc: "1117.88105236864",
      totalVolume: "$1,457,244",
      totalVolumeBtc: "28.1554427528497",
      sparkline: "https://www.coingecko.com/coins/12549/sparkline.svg",
      content: nil
    )
  )),

  // Kizuna (KIZUNA)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "kizuna",
    coinId: 32113,
    name: "Kizuna",
    symbol: "KIZUNA",
    marketCapRank: 751,
    thumb: "https://assets.coingecko.com/coins/images/32113/thumb/IMG_9968.png?1696585475",
    small: "https://assets.coingecko.com/coins/images/32113/small/IMG_9968.png?1696585475",
    large: "https://assets.coingecko.com/coins/images/32113/large/IMG_9968.png?1696585475",
    slug: "kizuna",
    priceBtc: 7.532500761437208e-13,
    score: 3,
    data: TrendingCoinData(
      price: "$0.0<sub title=\"0.00000003899\">7</sub>3899",
      priceBtc: "0.000000000000753250076143721",
      priceChangePercentage24h: [
        "usd": 25.18621699339272,
        "btc": 26.21646475239856,
        "eth": 24.07831680209898,
        "krw": 25.439008244748113
      ],
      marketCap: "$37,752,174",
      marketCapBtc: "729.784118607182",
      totalVolume: "$716,639",
      totalVolumeBtc: "13.8462017580732",
      sparkline: "https://www.coingecko.com/coins/32113/sparkline.svg",
      content: nil
    )
  )),

  // Magic Square (SQR)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "magic-square",
    coinId: 26377,
    name: "Magic Square",
    symbol: "SQR",
    marketCapRank: 971,
    thumb: "https://assets.coingecko.com/coins/images/26377/thumb/bafkreictuxcsw472vuroqwv7maumzsa4pfhrdw6tglpme7zfdkce62niau_%281%29.jpg?1696525455",
    small: "https://assets.coingecko.com/coins/images/26377/small/bafkreictuxcsw472vuroqwv7maumzsa4pfhrdw6tglpme7zfdkce62niau_%281%29.jpg?1696525455",
    large: "https://assets.coingecko.com/coins/images/26377/large/bafkreictuxcsw472vuroqwv7maumzsa4pfhrdw6tglpme7zfdkce62niau_%281%29.jpg?1696525455",
    slug: "magic-square",
    priceBtc: 0.000010125010739661151,
    score: 4,
    data: TrendingCoinData(
      price: "$0.5238",
      priceBtc: "0.0000101250107396612",
      priceChangePercentage24h: [
        "usd": 1.6567581905044573,
        "btc": 2.5586610869810187,
        "eth": 0.8680431755742904,
        "krw": 1.8480304661991334
      ],
      marketCap: "$21,089,305",
      marketCapBtc: "407.69590938248",
      totalVolume: "$8,016,273",
      totalVolumeBtc: "154.94522540188",
      sparkline: "https://www.coingecko.com/coins/26377/sparkline.svg",
      content: nil
    )
  )),

  // Worldcoin (WLD)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "worldcoin-wld",
    coinId: 31069,
    name: "Worldcoin",
    symbol: "WLD",
    marketCapRank: 99,
    thumb: "https://assets.coingecko.com/coins/images/31069/thumb/worldcoin.jpeg?1696529903",
    small: "https://assets.coingecko.com/coins/images/31069/small/worldcoin.jpeg?1696529903",
    large: "https://assets.coingecko.com/coins/images/31069/large/worldcoin.jpeg?1696529903",
    slug: "worldcoin",
    priceBtc: 0.00012994360282262405,
    score: 5,
    data: TrendingCoinData(
      price: "$6.73",
      priceBtc: "0.000129943602822624",
      priceChangePercentage24h: [
        "usd": -0.6606807359827739,
        "btc": 0.1568542411970194,
        "eth": -1.5398354341505862,
        "krw": -0.4600826875021792
      ],
      marketCap: "$882,437,961",
      marketCapBtc: "17056.4991134345",
      totalVolume: "$1,475,319,197",
      totalVolumeBtc: "28504.6796616679",
      sparkline: "https://www.coingecko.com/coins/31069/sparkline.svg",
      content: nil
    )
  )),

  // Filecoin (FIL)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "filecoin",
    coinId: 12817,
    name: "Filecoin",
    symbol: "FIL",
    marketCapRank: 31,
    thumb: "https://assets.coingecko.com/coins/images/12817/thumb/filecoin.png?1696512609",
    small: "https://assets.coingecko.com/coins/images/12817/small/filecoin.png?1696512609",
    large: "https://assets.coingecko.com/coins/images/12817/large/filecoin.png?1696512609",
    slug: "filecoin",
    priceBtc: 0.00014131988391957436,
    score: 6,
    data: TrendingCoinData(
      price: "$7.31",
      priceBtc: "0.000141319883919574",
      priceChangePercentage24h: [
        "usd": 12.987926697691387,
        "btc": 13.854516785373383,
        "eth": 11.909351084489762,
        "krw": 13.216085676083269
      ],
      marketCap: "$3,726,443,339",
      marketCapBtc: "72015.8557689289",
      totalVolume: "$1,056,699,517",
      totalVolumeBtc: "20416.5181959134",
      sparkline: "https://www.coingecko.com/coins/12817/sparkline.svg",
      content: TrendingContentInfo(
        title: "What is Filecoin?",
        description: "Filecoin is a decentralized storage network based on the Interplanetary File Storage (IPFS) protocol. It is designed to utilized unused storage globally into an efficient storage market for users to pay for low cost storage. The objective is to ensure file storage is permanent and distributed across the web. Contrast this with centralized cloud storage solution such as Amazon Web Services, Google Cloud, or Dropbox, where data are stored in servers owned by these private corporations."
      )
    )
  )),

  // Fetch.ai (FET)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "fetch-ai",
    coinId: 5681,
    name: "Fetch.ai",
    symbol: "FET",
    marketCapRank: 86,
    thumb: "https://assets.coingecko.com/coins/images/5681/thumb/Fetch.jpg?1696506140",
    small: "https://assets.coingecko.com/coins/images/5681/small/Fetch.jpg?1696506140",
    large: "https://assets.coingecko.com/coins/images/5681/large/Fetch.jpg?1696506140",
    slug: "fetch-ai",
    priceBtc: 0.00001818786453107494,
    score: 7,
    data: TrendingCoinData(
      price: "$0.9414",
      priceBtc: "0.0000181878645310749",
      priceChangePercentage24h: [
        "usd": 6.608219133440514,
        "btc": 7.485575135496464,
        "eth": 5.664734545375545,
        "krw": 6.823495429559741
      ],
      marketCap: "$977,224,083",
      marketCapBtc: "18885.4685796771",
      totalVolume: "$541,892,955",
      totalVolumeBtc: "10469.9275313316",
      sparkline: "https://www.coingecko.com/coins/5681/sparkline.svg",
      content: nil
    )
  )),

  // PAAL AI (PAAL)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "paal-ai",
    coinId: 30815,
    name: "PAAL AI",
    symbol: "PAAL",
    marketCapRank: 258,
    thumb: "https://assets.coingecko.com/coins/images/30815/thumb/PaalX.jpg?1696529671",
    small: "https://assets.coingecko.com/coins/images/30815/small/PaalX.jpg?1696529671",
    large: "https://assets.coingecko.com/coins/images/30815/large/PaalX.jpg?1696529671",
    slug: "paal-ai",
    priceBtc: 0.000006509575744019403,
    score: 8,
    data: TrendingCoinData(
      price: "$0.3369",
      priceBtc: "0.0000065095757440194",
      priceChangePercentage24h: [
        "usd": -21.691099478142235,
        "btc": -21.089066366823246,
        "eth": -22.437926959667827,
        "krw": -21.53296861173682
      ],
      marketCap: "$218,739,932",
      marketCapBtc: "4228.44329869558",
      totalVolume: "$6,519,096",
      totalVolumeBtc: "125.957897074277",
      sparkline: "https://www.coingecko.com/coins/30815/sparkline.svg",
      content: nil
    )
  )),

  // Heroes of Mavia (MAVIA)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "heroes-of-mavia",
    coinId: 33895,
    name: "Heroes of Mavia",
    symbol: "MAVIA",
    marketCapRank: 239,
    thumb: "https://assets.coingecko.com/coins/images/33895/thumb/2023-12-20_21.21.41_%281%29.jpg?1703230771",
    small: "https://assets.coingecko.com/coins/images/33895/small/2023-12-20_21.21.41_%281%29.jpg?1703230771",
    large: "https://assets.coingecko.com/coins/images/33895/large/2023-12-20_21.21.41_%281%29.jpg?1703230771",
    slug: "heroes-of-mavia",
    priceBtc: 0.0001592602842705006,
    score: 9,
    data: TrendingCoinData(
      price: "$8.24",
      priceBtc: "0.000159260284270501",
      priceChangePercentage24h: [
        "usd": -15.584817493537905,
        "btc": -14.890104012356984,
        "eth": -16.331893322596162,
        "krw": -15.414356079080992
      ],
      marketCap: "$247,370,239",
      marketCapBtc: "4780.58509039822",
      totalVolume: "$103,895,156",
      totalVolumeBtc: "2007.36094969077",
      sparkline: "https://www.coingecko.com/coins/33895/sparkline.svg",
      content: nil
    )
  )),

  // Ronin (RON)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "ronin",
    coinId: 20009,
    name: "Ronin",
    symbol: "RON",
    marketCapRank: 88,
    thumb: "https://assets.coingecko.com/coins/images/20009/thumb/Ronin_Mark_Blue.png?1707125056",
    small: "https://assets.coingecko.com/coins/images/20009/small/Ronin_Mark_Blue.png?1707125056",
    large: "https://assets.coingecko.com/coins/images/20009/large/Ronin_Mark_Blue.png?1707125056",
    slug: "ronin",
    priceBtc: 0.0000626452586603899,
    score: 10,
    data: TrendingCoinData(
      price: "$3.24",
      priceBtc: "0.0000626452586603899",
      priceChangePercentage24h: [
        "usd": -1.3152504328591397,
        "btc": -0.5031023822876828,
        "eth": -2.1886121778584453,
        "krw": -1.1159741712073605
      ],
      marketCap: "$964,080,951",
      marketCapBtc: "18636.5680418382",
      totalVolume: "$139,385,990",
      totalVolumeBtc: "2693.08024694829",
      sparkline: "https://www.coingecko.com/coins/20009/sparkline.svg",
      content: TrendingContentInfo(
        title: "What is Ronin?",
        description: "Ronin is an EVM blockchain specifically forged for gaming. Launched by Sky Mavis, the creator of Web3's breakout title Axie Infinity which has generated over $1.3B in revenue, Ronin is the only blockchain proven to scale a single game to accommodate millions of daily active users and has processed over $4B in NFT volumes. Ronin optimizes for near-instant transactions and negligible fees that enable millions of in-game transactions to occur seamlessly, making it the leading choice for Web3 games."
      )
    )
  )),

  // Bittensor (TAO)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "bittensor",
    coinId: 28452,
    name: "Bittensor",
    symbol: "TAO",
    marketCapRank: 28,
    thumb: "https://assets.coingecko.com/coins/images/28452/thumb/ARUsPeNQ_400x400.jpeg?1696527447",
    small: "https://assets.coingecko.com/coins/images/28452/small/ARUsPeNQ_400x400.jpeg?1696527447",
    large: "https://assets.coingecko.com/coins/images/28452/large/ARUsPeNQ_400x400.jpeg?1696527447",
    slug: "bittensor",
    priceBtc: 0.012163135434065395,
    score: 11,
    data: TrendingCoinData(
      price: "$629.53",
      priceBtc: "0.0121631354340654",
      priceChangePercentage24h: [
        "usd": -6.93379748946708,
        "btc": -6.1678885189873816,
        "eth": -7.757434995582034,
        "krw": -6.745866882116168
      ],
      marketCap: "$3,908,369,099",
      marketCapBtc: "75549.1857999045",
      totalVolume: "$25,480,348",
      totalVolumeBtc: "492.306443747628",
      sparkline: "https://www.coingecko.com/coins/28452/sparkline.svg",
      content: TrendingContentInfo(
        title: "What is Bittensor?",
        description: "Bittensor is an open-source protocol that utilizes blockchain technology to create a decentralized machine learning network. This network enables machine learning models to train collaboratively and be rewarded in TAO according to the informational value they offer the collective. Additionally, Bittensor's TAO grants external access to users, allowing them to extract information from the network while tuning its activities to meet their needs. The ultimate vision of Bittensor is to create a market for artificial intelligence, allowing producers and consumers of this commodity to interact in a trustless, open, and transparent context. Bittensor provides a novel strategy for developing and distributing artificial intelligence technology, promoting open access/ownership, decentralized governance, and global access to computing power and innovation within an incentivized framework. The Bittensor network operates using two types of nodes, servers and validators, with assessments based on the value of their responses. Nodes that add value to the network are rewarded with more stake (TAO), while low-value nodes are weakened and eventually de-registered."
      )
    )
  )),

  // Dymension (DYM)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "dymension",
    coinId: 34182,
    name: "Dymension",
    symbol: "DYM",
    marketCapRank: 78,
    thumb: "https://assets.coingecko.com/coins/images/34182/thumb/dym.png?1704253006",
    small: "https://assets.coingecko.com/coins/images/34182/small/dym.png?1704253006",
    large: "https://assets.coingecko.com/coins/images/34182/large/dym.png?1704253006",
    slug: "dymension",
    priceBtc: 0.00014036446157740035,
    score: 12,
    data: TrendingCoinData(
      price: "$7.26",
      priceBtc: "0.0001403644615774",
      priceChangePercentage24h: [
        "usd": -2.8279872974234372,
        "btc": -2.0827014472505794,
        "eth": -3.755585194384068,
        "krw": -2.6317657382313464
      ],
      marketCap: "$1,057,181,162",
      marketCapBtc: "20430.6893122983",
      totalVolume: "$82,228,777",
      totalVolumeBtc: "1588.74428796239",
      sparkline: "https://www.coingecko.com/coins/34182/sparkline.svg",
      content: nil
    )
  )),

  // AltLayer (ALT)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "altlayer",
    coinId: 34608,
    name: "AltLayer",
    symbol: "ALT",
    marketCapRank: 139,
    thumb: "https://assets.coingecko.com/coins/images/34608/thumb/altlayer.jpeg?1705497960",
    small: "https://assets.coingecko.com/coins/images/34608/small/altlayer.jpeg?1705497960",
    large: "https://assets.coingecko.com/coins/images/34608/large/altlayer.jpeg?1705497960",
    slug: "altlayer",
    priceBtc: 0.000008818699547363353,
    score: 13,
    data: TrendingCoinData(
      price: "$0.4564",
      priceBtc: "0.00000881869954736335",
      priceChangePercentage24h: [
        "usd": 4.773008593363584,
        "btc": 5.635261322937722,
        "eth": 3.84576565040339,
        "krw": 4.98457900891488
      ],
      marketCap: "$499,705,597",
      marketCapBtc: "9657.42620710645",
      totalVolume: "$211,015,817",
      totalVolumeBtc: "4077.04195420649",
      sparkline: "https://www.coingecko.com/coins/34608/sparkline.svg",
      content: nil
    )
  )),

  // Sei (SEI)
  TrendingCoinItem(item: TrendingCoinDetails(
    id: "sei-network",
    coinId: 28205,
    name: "Sei",
    symbol: "SEI",
    marketCapRank: 47,
    thumb: "https://assets.coingecko.com/coins/images/28205/thumb/Sei_Logo_-_Transparent.png?1696527207",
    small: "https://assets.coingecko.com/coins/images/28205/small/Sei_Logo_-_Transparent.png?1696527207",
    large: "https://assets.coingecko.com/coins/images/28205/large/Sei_Logo_-_Transparent.png?1696527207",
    slug: "sei",
    priceBtc: 0.000017393466135210818,
    score: 14,
    data: TrendingCoinData(
      price: "$0.9002",
      priceBtc: "0.0000173934661352108",
      priceChangePercentage24h: [
        "usd": -5.207005145348561,
        "btc": -4.4799657870415475,
        "eth": -6.111893088165058,
        "krw": -5.015587588651448
      ],
      marketCap: "$2,293,078,862",
      marketCapBtc: "44327.3152687686",
      totalVolume: "$236,475,825",
      totalVolumeBtc: "4568.95542643334",
      sparkline: "https://www.coingecko.com/coins/28205/sparkline.svg",
      content: nil
    )
  ))
]

// 인기 NFT 목데이터
let mockTrendingNFTs: [TrendingNFTItem] = [
  // ARCStellars (ARS)
  TrendingNFTItem(
    id: "arc-stellars",
    name: "ARCStellars",
    symbol: "ARS",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3717/small/arc-stellars.png?1707290159",
    nftContractId: 3717,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 68.9999,
    floorPrice24hPercentageChange: 2347.24743098032,
    data: TrendingNFTData(
      floorPrice: "69.00 ETH",
      floorPriceInUsd24hPercentageChange: "2347.24743098032",
      h24Volume: "5.89 ETH",
      h24AverageSalePrice: "2.94 ETH",
      sparkline: "https://www.coingecko.com/nft/3717/sparkline.svg",
      content: nil
    )
  ),

  // NFTrees (TREE)
  TrendingNFTItem(
    id: "nftrees",
    name: "NFTrees",
    symbol: "TREE",
    thumb: "https://assets.coingecko.com/nft_contracts/images/939/small/nftrees.png?1707287576",
    nftContractId: 939,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 9.6,
    floorPrice24hPercentageChange: 55.4038877005999,
    data: TrendingNFTData(
      floorPrice: "9.60 ETH",
      floorPriceInUsd24hPercentageChange: "55.4038877005999",
      h24Volume: "38.50 ETH",
      h24AverageSalePrice: "6.42 ETH",
      sparkline: "https://www.coingecko.com/nft/939/sparkline.svg",
      content: nil
    )
  ),

  // Sam Spratt - LUCI: Chapter 5 - The Monument Game
  TrendingNFTItem(
    id: "sam-spratt-luci-chapter-5-the-monument-game",
    name: "Sam Spratt - LUCI: Chapter 5 - The Monument Game",
    symbol: "SAMSPRATTLUCICHAPTERTHEMONUMENTGAME",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3440/small/sam-spratt-luci-chapter-5-the-monument-game.png?1707290022",
    nftContractId: 3440,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 11.11,
    floorPrice24hPercentageChange: 49.7015001867071,
    data: TrendingNFTData(
      floorPrice: "11.11 ETH",
      floorPriceInUsd24hPercentageChange: "49.7015001867071",
      h24Volume: "4.01 ETH",
      h24AverageSalePrice: "4.01 ETH",
      sparkline: "https://www.coingecko.com/nft/3440/sparkline.svg",
      content: nil
    )
  ),

  // The Seekers (SEEKERS)
  TrendingNFTItem(
    id: "the-seekers",
    name: "The Seekers",
    symbol: "SEEKERS",
    thumb: "https://assets.coingecko.com/nft_contracts/images/301/small/the-seekers.png?1707287260",
    nftContractId: 301,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 0.0599,
    floorPrice24hPercentageChange: 43.1951052031483,
    data: TrendingNFTData(
      floorPrice: "0.060 ETH",
      floorPriceInUsd24hPercentageChange: "43.1951052031483",
      h24Volume: "11.66 ETH",
      h24AverageSalePrice: "0.10 ETH",
      sparkline: "https://www.coingecko.com/nft/301/sparkline.svg",
      content: nil
    )
  ),

  // rektguy (Rektguy)
  TrendingNFTItem(
    id: "rektguy",
    name: "rektguy",
    symbol: "Rektguy",
    thumb: "https://assets.coingecko.com/nft_contracts/images/396/small/rektguy.gif?1707287298",
    nftContractId: 396,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 0.819,
    floorPrice24hPercentageChange: 31.1656617877006,
    data: TrendingNFTData(
      floorPrice: "0.82 ETH",
      floorPriceInUsd24hPercentageChange: "31.1656617877006",
      h24Volume: "55.53 ETH",
      h24AverageSalePrice: "0.74 ETH",
      sparkline: "https://www.coingecko.com/nft/396/sparkline.svg",
      content: nil
    )
  ),

  // Sappy Seals (SAPS)
  TrendingNFTItem(
    id: "sappy-seals",
    name: "Sappy Seals",
    symbol: "SAPS",
    thumb: "https://assets.coingecko.com/nft_contracts/images/1331/small/sappy-seals.png?1707287784",
    nftContractId: 1331,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 1.1298,
    floorPrice24hPercentageChange: 25.5871981522824,
    data: TrendingNFTData(
      floorPrice: "1.13 ETH",
      floorPriceInUsd24hPercentageChange: "25.5871981522824",
      h24Volume: "369.84 ETH",
      h24AverageSalePrice: "1.16 ETH",
      sparkline: "https://www.coingecko.com/nft/1331/sparkline.svg",
      content: nil
    )
  ),

  // Candy Collective: Genesis Collection (CANDY)
  TrendingNFTItem(
    id: "candy-collective-genesis-collection",
    name: "Candy Collective: Genesis Collection",
    symbol: "CANDY",
    thumb: "https://assets.coingecko.com/nft_contracts/images/3682/small/candy-collective-genesis-collection.png?1707290140",
    nftContractId: 3682,
    nativeCurrencySymbol: "eth",
    floorPriceInNativeCurrency: 0.8899,
    floorPrice24hPercentageChange: 23.6097649366297,
    data: TrendingNFTData(
      floorPrice: "0.89 ETH",
      floorPriceInUsd24hPercentageChange: "23.6097649366297",
      h24Volume: "90.36 ETH",
      h24AverageSalePrice: "0.79 ETH",
      sparkline: "https://www.coingecko.com/nft/3682/sparkline.svg",
      content: nil
    )
  )
]
