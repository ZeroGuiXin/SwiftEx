//
//  UIImageEx.swift
//  SwiftExtension
//
//  Created by xuzexin on 2022/3/21.
//

import UIKit

extension UIImage {
    
    static func color(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    // 压缩
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }

    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }
}
