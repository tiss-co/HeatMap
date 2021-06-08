//
//  ImageHelper.swift
//  HeatMap
//
//  Created by Amir on 6/3/21.
//

import Foundation

class ImageHelper {
    static func image(_ name: String) -> UIImage? {
        let podBundle = Bundle(for: ImageHelper.self)
        if let url = podBundle.url(forResource: "HeatMap", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return UIImage()
    }
}
