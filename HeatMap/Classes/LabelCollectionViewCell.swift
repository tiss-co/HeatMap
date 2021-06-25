//
//  LabelCollectionViewCell.swift
//  HeatMap
//
//  Created by Amir on 6/1/21.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getDate(title: String) {
        self.label.text = title
    }
    
    func getData(seprateValues: Double) {
        let value = Int(((seprateValues * 10).rounded())/10)
        self.label.text = value.thousandSeprate()
    }
    
    func setUI(font: UIFont, color: UIColor, backgroundColor: UIColor) {
        self.label.font = font
        self.label.textColor = color
        containerView.backgroundColor = backgroundColor
    }

}

extension LabelCollectionViewCell {
    class func register(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: LabelCollectionViewCell.nameOfClass,
                                      bundle: HeatMapFrameworkBundle.main),
                                forCellWithReuseIdentifier:  LabelCollectionViewCell.nameOfClass)
    }
}
