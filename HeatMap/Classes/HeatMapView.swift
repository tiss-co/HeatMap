//
//  HeatMapView.swift
//  HeatMap
//
//  Created by Amir on 6/2/21.
//

import UIKit

public final class HeatMapFrameworkBundle {
    public static let main: Bundle = Bundle(for: HeatMapFrameworkBundle.self)
}

public class HeatMapView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tooltipView: UIView!
    @IBOutlet weak var tooltipStackView: UIStackView!
    @IBOutlet weak var tooltipRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tootipWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gaugeCollectionView: UICollectionView!
    @IBOutlet public weak var indicatorImageView: UIImageView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    @IBOutlet weak var leadingConstraintIndicator: NSLayoutConstraint! //Defualt = -5
    
    public var data: HeatMapModel? {
        didSet {
            calcuteSeprateValues()
        }
    }
    
    //MARK:- Tooltip section properties
    private var tooltipStackViewTag: Int = 666333
    public var tooltipBackgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.6) {
        didSet {
            self.tooltipView.backgroundColor = tooltipBackgroundColor
        }
    }
    
    public var tooltipWidth: CGFloat = 140 {
        didSet {
            tootipWidthConstraint.constant = tooltipWidth
        }
    }
    
    public var tooltipPadding: CGFloat = 10
    public var tooltipTextColor: UIColor = .black
    public var tooltipItemsSpacing: CGFloat = 8
    public var tooltipTitleFont: UIFont = UIFont.systemFont(ofSize: 13)
    public var tooltipValueFont: UIFont = UIFont.systemFont(ofSize: 11)
    public var tooltipUnitFont: UIFont = UIFont.systemFont(ofSize: 10)
    
    var seprateValues: [Double] = []
    var selectedRow: Int?
    var selectedIndex: Int?
    
    public var isTimeLabelHidden: Bool = true {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var isDateLabelHidden: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var itemCornerRadius: CGFloat = 0.0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var itemBorderSelectedColor: UIColor = .red {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var itemSelectedBorderWidth: CGFloat = 1.5 {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var itemBorderColor: UIColor = .lightGray {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var itemBorderWidth: CGFloat = 0.0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var itemBackgroundColorDisable: UIColor = .lightGray {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var dateLabelWidth: CGFloat = 50 {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var dateFormatString: String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var showDateFormatString: String? {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var dateLabelFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var dateLabelTextColor: UIColor = .black {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var timeLabelTextColor: UIColor = .black {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var timeLabelFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var timeLabelBackgroundColor: UIColor = .clear {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var gaugeCornerRadius: CGFloat = 0 {
        didSet {
            gaugeCollectionView.layer.cornerRadius = gaugeCornerRadius
        }
    }
    
    public var gaugeItemCornerRadius: CGFloat = 0 {
        didSet {
            gaugeCollectionView.reloadData()
        }
    }
    
    public var gaugeItemBorderWidth: CGFloat = 0 {
        didSet {
            gaugeCollectionView.reloadData()
        }
    }
    
    public var gaugeItemBorderColor: UIColor = .clear {
        didSet {
            gaugeCollectionView.reloadData()
        }
    }
        
    public var unitString: String = "" {
        didSet {
            labelCollectionView.reloadData()
        }
    }
    
    public var segmentFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            labelCollectionView.reloadData()
        }
    }
    
    public var segmentTextColor: UIColor = .black {
        didSet {
            labelCollectionView.reloadData()
        }
    }
    
    public var segmentBackgroundColor: UIColor = .clear {
        didSet {
            labelCollectionView.reloadData()
        }
    }
    
    public var gaugeLabelContainerRadius: CGFloat = 0 {
        didSet {
            labelCollectionView.layer.cornerRadius = gaugeLabelContainerRadius
        }
    }
    
    
    public var indicatorImage: UIImage? = ImageHelper.image("up-triangular-arrow-H") {
        didSet {
            indicatorImageView.image = indicatorImage
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        commonInit()
        registerCells()
        setupTableView()
        setupCollectionView()
        setupIndicatorImage()
        setupTooltip()
    }
    
    func commonInit() {
        HeatMapFrameworkBundle.main.loadNibNamed(HeatMapView.nameOfClass, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func registerCells() {
        HeatMapTableViewCell.register(for: tableView)
        TimeTableViewCell.register(for: tableView)
        ColorCollectionViewCell.register(for: gaugeCollectionView)
        LabelCollectionViewCell.register(for: labelCollectionView)
    }
    
    public func refreshUI() {
        tableView.reloadData()
        gaugeCollectionView.reloadData()
        labelCollectionView.reloadData()
        tableView.beginUpdates()
        tableView.endUpdates()
        calcuteHeightTableView()
    }
    
    public func refreshHeatMapLayout() {
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            gaugeCollectionView.collectionViewLayout.invalidateLayout()
            labelCollectionView.collectionViewLayout.invalidateLayout()
            calcuteHeightTableView()
            guard let row = selectedRow, let index = selectedIndex else { return }
            animateIndicator(row: row, index: index)
            setTooltip(row: row, index: index)
        }
    }
    
    func calcuteHeightTableView() {
        tableView.layoutIfNeeded()
        let height = tableView.contentSize.height
        tableViewHeightConstraint.constant = height
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func setupCollectionView() {
        gaugeCollectionView.dataSource = self
        gaugeCollectionView.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.delegate = self
    }
    
    func setupIndicatorImage() {
        self.indicatorImageView.image = indicatorImage
    }
    
    func calcuteSeprateValues() {
        guard let data = data?.data else { return }
        var values: [Double] = []
        for item in data {
            values.append(contentsOf: item.values.map{$0.value})
        }
        if let min = values.min(),
           let max = values.max() {
            seprateValues = caluteBetweenValues(min: min, max: max)
        }
        refreshUI()
    }
    
    func caluteBetweenValues(min: Double, max: Double) -> [Double] {
        guard let data = data?.seprateGaugePercents, data.count > 2 else { return [min,max] }
        var values: [Double] = [min]
        
        let range = max - min
        for (index,item) in data.enumerated() {
            if index == 0 { continue }
            let value = (range * Double(item) / 100) + min
            values.append(value)
        }
        return values
    }
}



extension HeatMapView: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if isTimeLabelHidden {
            return 1
        } else {
            return 2
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let heatMapData = data else { return 0 }
        let days = heatMapData.data.count
        return section == 0 ? days : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return heatMapTableViewCell(indexPath: indexPath)
        } else {
            return timeTableViewCell(indexPath: indexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return caluteHeightTableViewCell()
        } else {
            return 20
        }
    }
    
    func heatMapTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: HeatMapTableViewCell.nameOfClass, for: indexPath) as! HeatMapTableViewCell
        cell.selectedItemDelegate = self
        cell.row = indexPath.row
        if indexPath.row == selectedRow {
            cell.indexItemSelected = selectedIndex
        }else {
            cell.indexItemSelected = nil
        }
        
        cell.setUI(isDateHidden: isDateLabelHidden,
                   dateFont: dateLabelFont,
                   dateTextColor: dateLabelTextColor,
                   dateLabelWidth: dateLabelWidth,
                   dateFormatString: dateFormatString,
                   showDateFormatString: showDateFormatString,
                   itemCornerRadius: itemCornerRadius,
                   itemBorderColor: itemBorderColor,
                   itemBorderWidth: itemBorderWidth,
                   itemBorderColorSelected: itemBorderSelectedColor,
                   itemSelectedBorderWidth: itemSelectedBorderWidth)
        cell.getData(data: data.data[indexPath.item],
                     colors: data.colors,
                     seprateValues: seprateValues,
                     timesCount: data.timeLabels.count)
        cell.collectionReloadLayout()
        return cell
    }
    
    func timeTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.nameOfClass, for: indexPath) as! TimeTableViewCell
        cell.getDate(data: data.timeLabels)
        cell.setUI(labelTextColor: timeLabelTextColor,
                   LabelFont: timeLabelFont,
                   labelBackground: timeLabelBackgroundColor)
        cell.collectionReloadLayout()
        return cell
    }
    
    func caluteHeightTableViewCell() -> CGFloat {
        let cellWidth = tableView.frame.width
        let collectionWidth = cellWidth - dateLabelWidth
        let squardCollectionCellSize = collectionWidth / CGFloat(data?.timeLabels.count ?? 1)
        return squardCollectionCellSize
    }
}

extension HeatMapView: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        if collectionView == gaugeCollectionView {
            return data.colors.count
        } else {
            return seprateValues.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gaugeCollectionView {
            return colorCollectionViewCell(indexPath: indexPath)
        } else {
            return labelCollectionVuewCell(indexPath: indexPath)
        }
    }
    
    func colorCollectionViewCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gaugeCollectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.nameOfClass, for: indexPath) as! ColorCollectionViewCell
        guard let data = data else { return cell }
        let index = indexPath.item
        cell.getData(color: data.colors[index])
        cell.setUI(cornerRadius: gaugeItemCornerRadius,
                   borderWidth: gaugeItemBorderWidth,
                   borderColor: gaugeItemBorderColor)
        return cell
    }
    
    func labelCollectionVuewCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = labelCollectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.nameOfClass, for: indexPath) as! LabelCollectionViewCell
        let index = indexPath.item
        let value = seprateValues[index]
        
        cell.getData(seprateValues: value,
                     unitString: unitString)
        cell.setUI(font: segmentFont,
                   color: segmentTextColor,
                   backgroundColor: segmentBackgroundColor)
        
        return cell
    }
}

extension HeatMapView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == gaugeCollectionView {
            return gaugeCellSize()
        } else {
            return labelCellSize()
        }
    }
    
    func gaugeCellSize() -> CGSize {
        guard let data = data else { return .zero}
        let collectionWidth = gaugeCollectionView.frame.width
        let collectionHeight = gaugeCollectionView.frame.height
        let squardSize = collectionWidth / CGFloat(data.colors.count)
        return CGSize(width: squardSize, height: collectionHeight)
    }
    
    func labelCellSize() -> CGSize {
        guard let data = data else { return .zero}
        let collectionWidth = labelCollectionView.frame.width
        let collectionHeight = labelCollectionView.frame.height
        let squardSize = collectionWidth / CGFloat(data.seprateGaugePercents.count)
        return CGSize(width: squardSize, height: collectionHeight)
    }
}


extension HeatMapView: SelectItemDelegate {
    func selected(row: Int, index: Int) {
        self.selectedRow = row
        self.selectedIndex = index
        setTooltip(row: row, index: index)
        animateIndicator(row: row, index: index)
        self.tableView.reloadData()
    }
    
    func animateIndicator(row: Int, index: Int) {
        guard let data = data else { return }
        if !data.data.indices.contains(row) { return }
        if !data.data[row].values.indices.contains(index) { return }
        let value = data.data[row].values[index].value
        let max = seprateValues.max() ?? 0
        let min = seprateValues.min() ?? 0
        let range = max - min
        let diff = value - min
        let percentAnimate = CGFloat(diff / range)
        let animateDistance = gaugeCollectionView.frame.width * percentAnimate
        DispatchQueue.main.async {
            self.leadingConstraintIndicator.constant = animateDistance - 5
            UIView.animate(withDuration: 0.6) {
                self.layoutIfNeeded()
            }
        }
    }
}

protocol SelectItemDelegate {
    func selected(row: Int, index: Int)
}


//MARK:- Tooltip
extension HeatMapView {
    func setupTooltip() {
        self.tooltipView.layer.cornerRadius = 8
        self.tooltipView.backgroundColor = tooltipBackgroundColor.withAlphaComponent(0.6)
        self.tooltipStackView.backgroundColor = .clear
        setupRemovedTooltipGesture()
    }
    
    func setupRemovedTooltipGesture(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dismissTooltip(sender:)))
        doubleTap.numberOfTouchesRequired = 2
        self.addGestureRecognizer(doubleTap)
        let tapOnTooltip = UITapGestureRecognizer(target: self, action: #selector(dismissTooltip(sender:)))
        tapOnTooltip.numberOfTouchesRequired = 1
        tooltipView.addGestureRecognizer(tapOnTooltip)
    }
    
    @objc func dismissTooltip(sender: UITapGestureRecognizer){
        tooltipStackView.removeAllArrangedSubviews()
        tooltipView.isHidden = true
    }
    
    func setTooltip(row:Int, index: Int){
        var stackView : [UIView] = []
        findTooltipPosition(index: index)
        addTimeToTooltip(stackView: &stackView,
                         row: row,
                         index: index)
        addEnableDataToTooltip(stackView: &stackView,
                               row: row,
                               index: index)
        DispatchQueue.main.async {
            self.presentTooltip(stackView: stackView)
        }
    }
    
    func addTimeToTooltip(stackView: inout [UIView],row: Int, index: Int){
        guard let data = data else { return }
        if !data.data.indices.contains(row) { return }
        if !data.data[row].values.indices.contains(index) { return }
        let timeLbl = UILabel()
        timeLbl.font = tooltipTitleFont
        timeLbl.textColor = tooltipTextColor
        timeLbl.textAlignment = .left
        timeLbl.text = data.data[row].date + " " + data.data[row].values[index].time
        stackView.append(timeLbl)
    }
    
    func addEnableDataToTooltip(stackView: inout [UIView],
                                row: Int,
                                index: Int){
        guard let data = data else { return }
        if !data.data.indices.contains(row) { return }
        if !data.data[row].values.indices.contains(index) { return }
        let titleLbl = UILabel()
        titleLbl.font = tooltipTitleFont
        titleLbl.textColor = tooltipTextColor
        titleLbl.textAlignment = .left
        titleLbl.text = data.name + ": "
        let valueLbl = UILabel()
        valueLbl.font = tooltipValueFont
        valueLbl.textColor = tooltipTextColor
        valueLbl.textAlignment = .right
        let value = data.data[row].values[index].value
        valueLbl.text = String(format: "%.2f",value)
        let unitLabel = UILabel()
        unitLabel.font = tooltipUnitFont
        unitLabel.textColor = tooltipTextColor
        unitLabel.textAlignment = .left
        unitLabel.text = " " + unitString
        let unitWidth = unitLabel.intrinsicContentSize.width
        unitLabel.widthAnchor.constraint(equalToConstant: unitWidth).isActive = true
        let vStack = UIStackView(arrangedSubviews: [titleLbl,valueLbl,unitLabel])
        vStack.distribution = .fill
        stackView.append(vStack)
    }
    
    func presentTooltip(stackView: [UIView]) {
        tooltipStackView.removeAllArrangedSubviews()
        if stackView.count == 0{
            return
        }else{
            tooltipView.isHidden = false
        }
        let vStack = UIStackView(arrangedSubviews: stackView)
        vStack.tag = tooltipStackViewTag
        vStack.axis = .vertical
        vStack.spacing = tooltipItemsSpacing
        tooltipStackView.addArrangedSubview(vStack)
        tooltipStackView.distribution = .fillEqually
    }
    
    func findTooltipPosition(index: Int) {
        guard let data = data else { return }
        if isDateLabelHidden {
            if index < data.timeLabels.count / 2 {
                setTooltipPostion(position: .left)
                return
            }
        } else {
            if index < data.timeLabels.count / 3 {
                setTooltipPostion(position: .left)
                return
            }
        }
        setTooltipPostion(position: .right)
    }
    
    func setTooltipPostion(position: tooltipPositionEnum) {
        let screenWidth = self.tableView.frame.width
        let tooltipWidth = self.tooltipView.frame.width
        var padding: CGFloat = tooltipPadding
        
        switch position {
        case .right:
            padding = screenWidth - tooltipWidth - padding - dateLabelWidth
            self.tooltipRightConstraint.constant = padding
        case .left:
            self.tooltipRightConstraint.constant = padding
        }
    }
    
    enum tooltipPositionEnum {
        case right
        case left
    }
}
