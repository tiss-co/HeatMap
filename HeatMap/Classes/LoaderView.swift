//
//  LoaderView.swift
//  HeatMap_Example
//
//  Created by Amir on 6/25/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public final class LoaderFrameworkBundle {
    public static let main: Bundle = Bundle(for: LoaderFrameworkBundle.self)
}

public class LoaderView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var ObjectsView: [UIView]!
    
    private var index = 0
    
    public var baseObjectColor: UIColor = .yellow {
        didSet {
            setupUI()
        }
    }
    
    public var animatedObjectColor: UIColor = .orange {
        didSet {
            setupUI()
        }
    }
    
    public var borderColor: UIColor = .white {
        didSet {
            setupUI()
        }
    }
    
    public var stackItemSpace: CGFloat = 5.0 {
        didSet {
            stackView.spacing = stackItemSpace
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
        setupUI()
        animating()
    }
    
    func commonInit() {
        LoaderFrameworkBundle.main.loadNibNamed(LoaderView.nameOfClass, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func setupUI() {
        for item in ObjectsView {
            item.layer.cornerRadius = item.frame.height / 4
            item.backgroundColor = baseObjectColor
            item.layer.borderWidth = 0.5
            item.layer.borderColor = borderColor.cgColor
        }
        ObjectsView.first?.backgroundColor = animatedObjectColor
    }
    
    func animating() {
        UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: { [self] in
            stackView.addArrangedSubview(stackView.subviews[index])
            if index == 2 {
                index = 0
            } else {
                index += 1
            }
        }, completion: {_ in
            self.animating()
        })
    }
}
