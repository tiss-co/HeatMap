//
//  HeatMapModel.swift
//  HeatMap
//
//  Created by Amir on 6/1/21.
//

import Foundation

public struct HeatMapModel {
    var name: String
    var seprateGaugePercents: [CGFloat]
    var colors: [UIColor]
    var data: [HeatMapDataModel]
    var timeLabels: [String]
    public init(name: String,
                colors: [UIColor],
                seprateGaugePercents: [CGFloat],
                data: [HeatMapDataModel],
                timeLabels: [String]) {
        self.name = name
        self.seprateGaugePercents = seprateGaugePercents
        self.colors = colors
        self.data = data
        self.timeLabels = timeLabels
    }
}

public struct HeatMapDataModel: Codable {
    var date: String
    var values: [HeatMapValueModel]
}

public struct HeatMapValueModel:Codable {
    var time: String
    var value: Double
    public init(time: String,
                value: Double) {
        self.time = time
        self.value = value
    }
}   
