//
//  AppIconType.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/7/25.
//

import UIKit

enum AppIconType {
    case up
    case down
    case search
    case star
    case star_fill
    case right
    case left
    case chart_Bar
    case uptrend_Chart
    
    var image: UIImage? {
        switch self {
        case .up:
            return UIImage(systemName: "arrowtriangle.up.fill")
        case .down:
            return UIImage(systemName: "arrowtriangle.down.fill")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .star:
            return UIImage(systemName: "star")
        case .star_fill:
            return UIImage(systemName: "star.fill")
        case .right:
            return UIImage(systemName: "chevron.right")
        case .left:
            let config = UIImage.SymbolConfiguration(weight: .bold)
            return UIImage(systemName: "arrow.left", withConfiguration: config)
        case .chart_Bar:
            return UIImage(systemName: "chart.bar.fill")
        case .uptrend_Chart:
            return UIImage(systemName: "chart.line.uptrend.xyaxis")
        }
    }
}
