//
//  UIImage+Hex.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/8.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static func image(withName imageStr: String) -> UIImage? {
        let image = UIImage(named: imageStr)?.withRenderingMode(.alwaysOriginal)
        return image
    }
    
    static func createImage(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func image(withCustomTintColor tintColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let area = CGRect(origin: .zero, size: size)
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0, y: -area.size.height)
        
        context.saveGState()
        context.clip(to: area, mask: cgImage!)
        
        tintColor.set()
        
        context.fill(area)
        
        context.restoreGState()
        context.setBlendMode(.destinationOver)
        context.draw(cgImage!, in: area)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.withRenderingMode(.alwaysOriginal)
    }
    
    static func snapshot(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
