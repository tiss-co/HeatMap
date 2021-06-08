# HeatMap

[![Version](https://img.shields.io/cocoapods/v/HeatMap.svg?style=flat)](https://cocoapods.org/pods/HeatMap)
[![License](https://img.shields.io/cocoapods/l/HeatMap.svg?style=flat)](https://cocoapods.org/pods/HeatMap)
[![Platform](https://img.shields.io/cocoapods/p/HeatMap.svg?style=flat)](https://cocoapods.org/pods/HeatMap)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


# Requirements
- Xcode 11+
- Swift 5
- iOS 9.0+

## Installation

HeatMap is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HeatMap'
```

### Create an instance of HeatMap
```swift
var heatmap: HeatMapView = HeatMapView(frame: view.bounds)

```
### Setup Data
```swift
let jsonString = """
    {
        "result": [
            {
                "date": "2021-06-02",
                "values": [
                    {
                        "time": "01:00",
                        "value": 31.944
                    }...
    }
    """
let jsonData = jsonString.data(using: .utf8)!
let result = try! JSONDecoder().decode(ResultRespons.self, from: jsonData)
let sepratePercents: [CGFloat] = [0,70,80,90,100]
let colors = [UIColor(red: 248/255, green: 207/255, blue: 117/255, alpha: 1),
              UIColor(red: 243/255, green: 180/255, blue: 71/255, alpha: 1),
              UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1),
              UIColor(red: 255/255, green: 93/255, blue: 0/255, alpha: 1)]
let data = HeatMapModel(name: "Demo",
                        colors: colors,
                        seprateGaugePercents: sepratePercents,
                        data: result.result,
                        timeLabels: timeLabels)
heatmap.data = data
heatmap.unitString: String = "MW"
```

### Customize HeatMap

- Date
```swift 
heatMap.isDateLabelHidden = false
heatMap.dateLabelWidth = 40
heatMap.dateFormatString = "yyyy-MM-dd" 
heatMap.showDateFormatString = "E"
heatMap.dateLabelFont = UIFont.systemFont(ofSize: 13) 
heatMap.dateLabelTextColor = .black
```
- HeatMap Item
```swift 
HeatMap.itemCornerRadius = 5
HeatMap.itemBorderSelectedColor = .red
HeatMap.itemSelectedBorderWidth = 1.5
HeatMap.itemBorderColor = .clear
HeatMap.itemBorderWidth = 0  
HeatMap.itemBackgroundColorDisable = .lightGray
```

- HeatMap Tooltip
```swift 
heatMap.tooltipBackgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
heatMap.tooltipWidth = 140
heatMap.tooltipPadding = 10
heatMap.tooltipTextColor = .black
heatMap.tooltipItemsSpacing = 8
heatMap.tooltipTitleFont = UIFont.systemFont(ofSize: 13) 
heatMap.tooltipValueFont = UIFont.systemFont(ofSize: 11) 
heatMap.tooltipUnitFont = UIFont.systemFont(ofSize: 10) 
```
- HeatMap Time Labels
```swift 
heatMap.isTimeLabelHidden = true
heatMap.timeLabelTextColor = .black
heatMap.timeLabelFont = UIFont.systemFont(ofSize: 6) 
heatMap.timeLabelBackgroundColor = .clear
```
- HeatMap Gauge
```swift 
heatMap.gaugeCornerRadius = 8
heatMap.gaugeItemCornerRadius = 4
heatMap.gaugeItemBorderWidth = 0 
heatMap.gaugeItemBorderColor = .clear
```
- HeatMap Gauge Indicator
```swift 
heatMap.indicatorImage = UIImage(name: ""up-triangular-arrow-H")
```

- HeatMap Gauge Segments
```swift 
heatMap.segmentFont = UIFont.systemFont(ofSize: 10) 
heatMap.segmentTextColor = .black
heatMap.segmentBackgroundColor = .clear
heatMap.gaugeLabelContainerRadius = 0
```

## Licence
Meter Gauge is available under the MIT license. See the [LICENSE.txt](https://github.com/boof-tech/MeterGauge/blob/main/LICENSE) file for more info.


## License

HeatMap is available under the MIT license. See the [LICENSE.txt](https://github.com/boof-tech/HeatMap/blob/main/LICENSE) file for more info.
