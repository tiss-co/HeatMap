//
//  ColorCollectionViewCell.swift
//  HeatMap
//
//  Created by Amir on 6/1/21.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func getData(color: UIColor) {
        self.containerView.backgroundColor = color
    }

    func getData(colors: [UIColor], values: [Double], data: HeatMapValueModel) {
        let value = data.value
        for index in 0..<values.count-1 {
            if value >= values[index] && value <= values[index+1] {
                containerView.backgroundColor = colors[index]
                return
            } else {
                continue
            }
        }
    }
    
    func setUI(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.borderWidth = borderWidth
        containerView.layer.borderColor = borderColor.cgColor
    }
}

extension ColorCollectionViewCell {
    class func register(for collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: ColorCollectionViewCell.nameOfClass,
                                      bundle: HeatMapFrameworkBundle.main),
                                forCellWithReuseIdentifier:  ColorCollectionViewCell.nameOfClass)
    }
}
