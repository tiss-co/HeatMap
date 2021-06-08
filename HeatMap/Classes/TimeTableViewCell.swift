//
//  TimeTableViewCell.swift
//  HeatMap
//
//  Created by Amir on 6/1/21.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [String] = []
    var timeLabelFont: UIFont = .systemFont(ofSize: 5)
    var timeLabelColor: UIColor = .black
    var timeLaeblBackgroundColor: UIColor = .clear
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        LabelCollectionViewCell.register(for: collectionView)
    }
    
    func getDate(data: [String]) {
        self.data = data
    }
    
    func setUI(labelTextColor: UIColor, LabelFont: UIFont, labelBackground: UIColor) {
        self.timeLabelFont = LabelFont
        self.timeLabelColor = labelTextColor
        self.timeLaeblBackgroundColor = labelBackground
    }
    
    func collectionReloadLayout(){
        DispatchQueue.main.async(execute: {
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    
}

extension TimeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.nameOfClass, for: indexPath) as! LabelCollectionViewCell
        cell.getDate(title: data[indexPath.item])
        cell.setUI(font: timeLabelFont, color: timeLabelColor, backgroundColor: timeLaeblBackgroundColor)
        return cell
    }
}

extension TimeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        let collectionHeight = collectionView.frame.height
        let squardSize = collectionWidth / CGFloat(data.count)
        return CGSize(width: squardSize, height: collectionHeight)
    }
}



extension TimeTableViewCell {
    class func register(for tableView: UITableView) {
        tableView.register(UINib(nibName: TimeTableViewCell.nameOfClass,
                                 bundle: HeatMapFrameworkBundle.main), forCellReuseIdentifier: TimeTableViewCell.nameOfClass)
    }
}
