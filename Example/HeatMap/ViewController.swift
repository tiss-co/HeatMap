//
//  ViewController.swift
//  HeatMap
//
//  Created by amirhoseinmrn on 06/01/2021.
//  Copyright (c) 2021 amirhoseinmrn. All rights reserved.
//

import UIKit
import HeatMap

class ViewController: UIViewController {
    
    @IBOutlet weak var heatMap: HeatMapView!
    
    let jsonString = """
    {
        "result": [
            {
                "date": "2021-06-02",
                "values": [
                    {
                        "time": "01:00",
                        "value": 31.944
                    },
                    {
                        "time": "02:00",
                        "value": 31.561799999999998
                    },
                    {
                        "time": "03:00",
                        "value": 31.905
                    },
                    {
                        "time": "04:00",
                        "value": 31.9266
                    },
                    {
                        "time": "05:00",
                        "value": 31.937399999999997
                    },
                    {
                        "time": "06:00",
                        "value": 31.9458
                    },
                    {
                        "time": "07:00",
                        "value": 31.846200000000003
                    },
                    {
                        "time": "08:00",
                        "value": 31.132199999999997
                    },
                    {
                        "time": "09:00",
                        "value": 36.5316
                    },
                    {
                        "time": "10:00",
                        "value": 36.732
                    },
                    {
                        "time": "11:00",
                        "value": 35.7888
                    },
                    {
                        "time": "12:00",
                        "value": 36.891000000000005
                    },
                    {
                        "time": "13:00",
                        "value": 36.316199999999995
                    },
                    {
                        "time": "14:00",
                        "value": 38.269800000000004
                    },
                    {
                        "time": "15:00",
                        "value": 36.671400000000006
                    },
                    {
                        "time": "16:00",
                        "value": 37.517399999999995
                    },
                    {
                        "time": "17:00",
                        "value": 36.9474
                    },
                    {
                        "time": "18:00",
                        "value": 36.381
                    },
                    {
                        "time": "19:00",
                        "value": 36.946799999999996
                    },
                    {
                        "time": "20:00",
                        "value": 36.419999999999995
                    },
                    {
                        "time": "21:00",
                        "value": 37.6938
                    },
                    {
                        "time": "22:00",
                        "value": 36.1482
                    },
                    {
                        "time": "23:00",
                        "value": 33.132000000000005
                    }
                ]
            },
            {
                "date": "2021-06-03",
                "values": [
                    {
                        "time": "00:00",
                        "value": 32.029799999999994
                    },
                    {
                        "time": "01:00",
                        "value": 31.982999999999997
                    },
                    {
                        "time": "02:00",
                        "value": 31.922999999999995
                    },
                    {
                        "time": "03:00",
                        "value": 31.92
                    },
                    {
                        "time": "04:00",
                        "value": 31.921799999999998
                    },
                    {
                        "time": "05:00",
                        "value": 31.931400000000004
                    },
                    {
                        "time": "06:00",
                        "value": 31.906200000000002
                    },
                    {
                        "time": "07:00",
                        "value": 31.8354
                    },
                    {
                        "time": "08:00",
                        "value": 31.141199999999998
                    },
                    {
                        "time": "09:00",
                        "value": 35.9556
                    },
                    {
                        "time": "10:00",
                        "value": 34.967400000000005
                    },
                    {
                        "time": "11:00",
                        "value": 37.5582
                    },
                    {
                        "time": "12:00",
                        "value": 35.658
                    },
                    {
                        "time": "13:00",
                        "value": 34.8198
                    },
                    {
                        "time": "14:00",
                        "value": 37.989
                    },
                    {
                        "time": "15:00",
                        "value": 34.9866
                    },
                    {
                        "time": "16:00",
                        "value": 35.9598
                    },
                    {
                        "time": "17:00",
                        "value": 36.740399999999994
                    },
                    {
                        "time": "18:00",
                        "value": 36.9072
                    },
                    {
                        "time": "19:00",
                        "value": 36.272999999999996
                    },
                    {
                        "time": "20:00",
                        "value": 36.3624
                    },
                    {
                        "time": "21:00",
                        "value": 35.98499999999999
                    },
                    {
                        "time": "22:00",
                        "value": 36.110400000000006
                    },
                    {
                        "time": "23:00",
                        "value": 33.0822
                    }
                ]
            },
            {
                "date": "2021-06-04",
                "values": [
                    {
                        "time": "00:00",
                        "value": 31.9542
                    }
                ]
            }
        ]
    }
    """
    let startDate: String = "2021-05-02"
    let endDate: String = "2021-05-03"
    let timeLabels = ["0","1","2","3","4","5","6","7","8",
                      "9","10","11","12","13","14","15","16",
                      "17","18","19","20","21","22","23"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonData = jsonString.data(using: .utf8)!
        let result = try! JSONDecoder().decode(ResultRespons.self, from: jsonData)
        let sepratePercents: [CGFloat] = [0,70,80,90,100]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let colors = [UIColor(red: 248/255, green: 207/255, blue: 117/255, alpha: 1),
                      UIColor(red: 243/255, green: 180/255, blue: 71/255, alpha: 1),
                      UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1),
                      UIColor(red: 255/255, green: 93/255, blue: 0/255, alpha: 1)]
        let data = HeatMapModel(name: "Amir",
                                colors: colors,
                                seprateGaugePercents: sepratePercents,
                                data: result.result,
                                timeLabels: timeLabels)
        
        heatMap.unitString = "kMW"
        heatMap.segmentTextColor = .white
        heatMap.segmentBackgroundColor = .brown
        heatMap.gaugeLabelContainerRadius = 5
        heatMap.gaugeItemCornerRadius = 4
        heatMap.gaugeItemBorderWidth = 0.5
        heatMap.gaugeItemBorderColor = .black
        heatMap.itemCornerRadius = 3
        heatMap.dateFormatString = "yyyy-MM-dd"
        heatMap.showDateFormatString = "E"
        heatMap.dateLabelWidth = 30
        heatMap.data = data
        heatMap.tooltipBackgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        heatMap.tooltipTextColor = .white
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        heatMap.refreshUI()
        heatMap.refreshHeatMapLayout()    
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
}

struct ResultRespons: Codable {
    var result: [HeatMapDataModel]
}

