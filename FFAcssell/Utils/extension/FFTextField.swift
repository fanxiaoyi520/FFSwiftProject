//
//  MMTextField.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/8.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class FFTextField: UITextField {
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var iconRect = super.leftViewRect(forBounds: bounds)
        iconRect.origin.x += 18 // 向右偏移 18 个点
        return iconRect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 45, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 45, dy: 0)
    }
}
