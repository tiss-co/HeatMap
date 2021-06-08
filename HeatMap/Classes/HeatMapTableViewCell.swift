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
    var timesLableCounts: Int?
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
                 timesCount: Int){
        self.heatMapData = data
        self.colors = colors
        self.seprateValues = seprateValues
        self.timesLableCounts = timesCount
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
        return timesLableCounts ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = heatMapData?.values else { return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.nameOfClass, for: indexPath) as! ColorCollectionViewCell
        guard let colors = colors, let seprateValues = seprateValues else { return cell }
        let index = indexPath.item
        if data.indices.contains(index) {
            let value = data[indexPath.item]
            cell.getData(colors: colors, values: seprateValues, currentValue: value.value)
        } else {
            cell.getData(color: .lightGray)
        }
        return setupCellUI(cell: cell, index: index)
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
        guard let row = row else {return}
        selectedItemDelegate?.selected(row: row, index: indexPath.item)
    }
}

extension HeatMapTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let count = timesLableCounts else { return .zero }
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
