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
            UIImage(systemName: "arrowtriangle.up.fill")
        case .down:
            UIImage(systemName: "arrowtriangle.down.fill")
        case .search:
            UIImage(systemName: "magnifyingglass")
        case .star:
            UIImage(systemName: "star")
        case .star_fill:
            UIImage(systemName: "star.fill")
        case .right:
            UIImage(systemName: "chevron.right")
        case .left:
            UIImage(systemName: "arrow.left")
        case .chart_Bar:
            UIImage(systemName: "chart.bar.fill")
        case .uptrend_Chart:
            UIImage(systemName: "chart.line.uptrend.xyaxis")
        }
    }
}
