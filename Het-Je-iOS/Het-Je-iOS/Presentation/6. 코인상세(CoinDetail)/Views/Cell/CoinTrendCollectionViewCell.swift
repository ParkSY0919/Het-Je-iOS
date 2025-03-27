//
//  CoinTrendCollectionViewCell.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/11/25.
//

import UIKit

import DGCharts
import SnapKit
import Then

final class CoinTrendCollectionViewCell: UICollectionViewCell {
    
    private let currentPriceLabel = UILabel()
    private let priceChangePercentage24hLabel = VariationRateComponent(variationRateType: .none(rate: "", alignment: .left))
    private let chartView = LineChartView()
    private let currentTimeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubviews(
            currentPriceLabel,
            priceChangePercentage24hLabel,
            chartView,
            currentTimeLabel
        )
    }
    
    private func setLayout() {
        currentPriceLabel.snp.makeConstraints {
            $0.top.leading.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        priceChangePercentage24hLabel.snp.makeConstraints {
            $0.top.equalTo(currentPriceLabel.snp.bottom).offset(4)
            $0.leading.equalTo(currentPriceLabel.snp.leading)
        }
        
        chartView.snp.makeConstraints {
            $0.top.equalTo(priceChangePercentage24hLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(230)
        }
        
        currentTimeLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(chartView.snp.bottom).offset(4)
            $0.leading.equalTo(currentPriceLabel.snp.leading)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    private func setStyle() {
        currentPriceLabel.setLabelUI(
            "",
            font: .systemFont(ofSize: 20, weight: .heavy),
            textColor: .primary
        )
        
        chartView.do {
            $0.noDataText = ""
            $0.noDataFont = .systemFont(ofSize: 20)
            $0.noDataTextColor = .white
            $0.backgroundColor = .white
            $0.legend.enabled = false
            $0.xAxis.drawGridLinesEnabled = false
            $0.xAxis.drawAxisLineEnabled = false
            $0.xAxis.drawLabelsEnabled = false
            
            $0.leftAxis.enabled = false
            $0.leftAxis.drawAxisLineEnabled = false
            $0.leftAxis.drawAxisLineEnabled = false
            $0.leftAxis.drawGridLinesEnabled = false
            
            $0.rightAxis.enabled = false
            $0.rightAxis.drawAxisLineEnabled = false
            $0.rightAxis.drawAxisLineEnabled = false
            $0.rightAxis.drawGridLinesEnabled = false
         
            $0.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
            $0.legend.enabled = false
        }
        
        currentTimeLabel.setLabelUI(
            "",
            font: .hetJeFont(.body_regular_12),
            textColor: .secondary
        )
        
        priceChangePercentage24hLabel.hideLabel()
    }
    
    func fetchCoinTrendCell(model: [DTO.Response.MarketAPIResponseModel], currentTime: String) {
        guard let model = model.first else {
            print("fetchCoinTrendCell model 에러 발생")
            return
        }
        
        currentPriceLabel.text = "₩" + CustomFormatterManager.shard.formatNum(num: model.currentPrice)
        
        let rate = model.priceChangePercentage24h ?? 0.0
        priceChangePercentage24hLabel.updateVariationRateType(rate: rate, alignment: .left)
        
        setLineData(lineChartView: chartView, lineChartDataEntries: entryData(values: model.sparklineIn7d.price))
        
        currentTimeLabel.text = currentTime
    }
    
    //데이터 적용
    func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry]) {
        //Entry들을 이용해 Data Set 만들기
        let lineChartdataSet = LineChartDataSet(entries: lineChartDataEntries)
        
        //차트 모드 설정
        lineChartdataSet.mode = .cubicBezier
        lineChartdataSet.cubicIntensity = 0.2 //곡선 강도
        
        //라인 스타일
        lineChartdataSet.drawValuesEnabled = false
        lineChartdataSet.drawCirclesEnabled = false
        
        //그라데이션
        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
        lineChartdataSet.fill = LinearGradientFill(gradient: gradient, angle: 90)
        lineChartdataSet.drawFilledEnabled = true
        
        //데이터 설정 및 차트 설정
        let lineChartData = LineChartData(dataSet: lineChartdataSet)
        lineChartView.data = lineChartData
        
        //차트 관련 추가설정
        lineChartView.animate(xAxisDuration: 1.5)
        lineChartView.dragEnabled = false
        lineChartView.setScaleEnabled(false)
    }

    //entry 만들기
    func entryData(values: [Double]) -> [ChartDataEntry] {
        //entry 담을 array
        var lineDataEntries: [ChartDataEntry] = []
        
        //담기
        for i in 0 ..< values.count {
            let lineDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            lineDataEntries.append(lineDataEntry)
        }
        
        //반환
        return lineDataEntries
    }
    
}
