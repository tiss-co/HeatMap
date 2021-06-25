//
//  HeatMapTableViewCell.swift
//  HeatMap
//
//  Created by Amir on 6/1/21.
//

import UIKit

class HeatMapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabelWidthConstraint: NSLayoutConstraint!
    
    
    var row: Int?
    var selectedItemDelegate: SelectItemDelegate? = nil
    var isDateHidden = false {
        didSet {
            dateLabel.isHidden = isDateHidden
        }
    }
    
    var heatMapData: HeatMapDataModel?
    var colors: [UIColor]?
    var seprateValues: [Double]?
    var timesLabels: [String]?
    var dateFormatString: String?
    var showDateFormatString: String?
    var indexItemSelected: Int? 
    var itemCornerRadius: CGFloat = 0.0
    var itemBorderColor: UIColor = .clear
    var itemBorderColorSelected: UIColor = .red
    var itemBorderWidth: CGFloat = 0
    var itemSelectedBorderWidth: CGFloat = 1.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCollectionView() {
        ColorCollectionViewCell.register(for: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionReloadLayout(){
        DispatchQueue.main.async(execute: {
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
    func getData(data: HeatMapDataModel,
                 colors: [UIColor],
                 seprateValues: [Double],
                 timesLabels: [String]){
        self.heatMapData = data
        self.colors = colors
        self.seprateValues = seprateValues
        self.timesLabels = timesLabels
        self.dateLabel.text = dateFormatter(dateString: data.date)
        collectionView.reloadData()
    }
    
    func dateFormatter(dateString: String) -> String {
        guard let importFormat = dateFormatString,
              let exportFormat = showDateFormatString else {
            return dateString
        }
        let importFormatter = DateFormatter()
        importFormatter.dateFormat = importFormat
        let exportFormatter = DateFormatter()
        exportFormatter.dateFormat = exportFormat
        
        guard let date = importFormatter.date(from: dateString) else { return dateString }
        return exportFormatter.string(from: date)
    }
    
    func setUI(isDateHidden: Bool,
               dateFont: UIFont,
               dateTextColor: UIColor,
               dateLabelWidth: CGFloat,
               dateFormatString: String?,
               showDateFormatString: String?,
               itemCornerRadius: CGFloat,
               itemBorderColor: UIColor,
               itemBorderWidth: CGFloat,
               itemBorderColorSelected: UIColor,
               itemSelectedBorderWidth: CGFloat) {
        self.dateLabel.isHidden = isDateHidden
        self.dateLabel.font = dateFont
        self.dateLabel.textColor = dateTextColor
        self.dateFormatString = dateFormatString
        self.showDateFormatString = showDateFormatString
        self.dateLabelWidthConstraint.constant = dateLabelWidth
        self.itemCornerRadius = itemCornerRadius
        self.itemBorderColor = itemBorderColor
        self.itemBorderWidth = itemBorderWidth
        self.itemBorderColorSelected = itemBorderColorSelected
        self.itemSelectedBorderWidth = itemSelectedBorderWidth
        collectionView.reloadData()
    }
}

extension HeatMapTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if heatMapData == nil {
            return 0
        }
        return timesLabels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = heatMapData?.values else { return UICollectionViewCell()}
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.nameOfClass, for: indexPath) as! ColorCollectionViewCell
        guard let colors = colors,
              let seprateValues = seprateValues,
              let timeLabels = timesLabels else { return cell }
        let index = indexPath.item
        compareDataWithLabel(cell: &cell,
                             index: index,
                             data: data,
                             colors: colors,
                             seprateValues: seprateValues,
                             timesLabels: timeLabels)
        return setupCellUI(cell: cell, index: index)
    }
    
    func compareDataWithLabel(cell: inout ColorCollectionViewCell,
                              index: Int,
                              data: [HeatMapValueModel],
                              colors: [UIColor],
                              seprateValues: [Double],
                              timesLabels: [String]) {
        let label = timesLabels[index]
        guard let value = findValueWithLabels(label: label, data: data) else {
            cell.getData(color: .lightGray)
            return
        }
        cell.getData(colors: colors, values: seprateValues, data: value)
    }
    
    func findValueWithLabels(label: String, data: [HeatMapValueModel]) -> HeatMapValueModel? {
        let values = data.filter{ $0.time == label}
        guard let value = values.first else { return nil }
        return value
    }
    
    func setupCellUI(cell: ColorCollectionViewCell, index: Int) -> UICollectionViewCell{
        guard let indexSelected = indexItemSelected,
              indexSelected == index else {
            cell.setUI(cornerRadius: itemCornerRadius,
                       borderWidth: itemBorderWidth,
                       borderColor: itemBorderColor)
            return cell
        }
        cell.setUI(cornerRadius: itemCornerRadius,
                   borderWidth: itemSelectedBorderWidth,
                   borderColor: itemBorderColorSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let row = row,
              let labels = timesLabels,
              let data = heatMapData?.values else {return}
        let index = indexPath.item
        let label = labels[index]
        let dataSelected = findValueWithLabels(label: label, data: data)
        selectedItemDelegate?.selected(row: row, index: index, data: dataSelected)
    }
}

extension HeatMapTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let count = timesLabels?.count else { return .zero }
        let collectionWidth = collectionView.frame.width
        let collectionHeight = collectionView.frame.height
        let squardSize = (collectionWidth / CGFloat(count))
        return CGSize(width: squardSize, height: collectionHeight)
    }
}

extension HeatMapTableViewCell {
    class func register(for tableView: UITableView) {
        tableView.register(UINib(nibName: HeatMapTableViewCell.nameOfClass,
                                 bundle: HeatMapFrameworkBundle.main), forCellReuseIdentifier: HeatMapTableViewCell.nameOfClass)
    }
}
