//
//  FontAndColorConst.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    static func backgroundColor() -> UIColor {
        return UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }

    static func backgroundColor03() -> UIColor {
        return UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.3)
    }

    static func secondBackgroundColor() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }

    static func popBackgroundColor() -> UIColor { // 弹窗背景
        return UIColor(hexString: "#FFFFFF")
    }

    static func navTitleColor() -> UIColor {
        return UIColor(hexString: "#252525")
    }

    static func titleColor() -> UIColor {
        return UIColor(hexString: "#292929")
    }

    static func titleColor2c() -> UIColor {
        return UIColor(hexString: "#2C2C2C")
    }

    static func titleColor3c() -> UIColor {
        return UIColor(hexString: "#3C3C3C")
    }

    static func titleColorc5() -> UIColor {
        return UIColor(hexString: "#C5C5C5")
    }

    static func titleColor33() -> UIColor {
        return UIColor(hexString: "#333333")
    }

    static func titleColor2e() -> UIColor {
        return UIColor(hexString: "#2E2E2E")
    }

    static func subTitleColor() -> UIColor {
        return UIColor(hexString: "#999999")
    }

    static func contentTitleColor() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }

    static func cellTitleColor() -> UIColor {
        return UIColor(hexString: "#000000")
    }

    static func cellTitleBackColor() -> UIColor {
        return UIColor(hexString: "#F5F5F5")
    }

    static func btnTitleColor() -> UIColor {
        return UIColor(hexString: "#333333")
    }

    static func btnSelTitleColor() -> UIColor {
        return UIColor(hexStringWithAlpha: "#333333", alpha: 0.3)
    }

    static func lineBtnTitleColor() -> UIColor {
        return UIColor(hexString: "#666666")
    }

    static func lineBtnSelTitleColor() -> UIColor {
        return UIColor(hexStringWithAlpha: "#666666", alpha: 0.3)
    }

    static func btnTitleColor1() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }

    static func btnSelTitleColor1() -> UIColor {
        return UIColor(hexStringWithAlpha: "#FFFFFF", alpha: 0.3)
    }

    static func btnBackgroundColor() -> UIColor {
        return UIColor(hexString: "#1890FF")
    }

    static func btnSelBackgroundColor() -> UIColor {
        return UIColor(hexStringWithAlpha: "#1890FF", alpha: 0.3)
    }

    static func btnBackgroundColornosel() -> UIColor {
        return UIColor(hexString: "#E5E5E5")
    }

    static func btnSelBackgroundColornosel() -> UIColor {
        return UIColor(hexStringWithAlpha: "#E5E5E5", alpha: 0.3)
    }

    static func btnBackgroundColorgray() -> UIColor {
        return UIColor(hexString: "#F5F5F7")
    }

    static func btnSelBackgroundColorgray() -> UIColor {
        return UIColor(hexStringWithAlpha: "#F5F5F7", alpha: 0.3)
    }

    static func btnBackgroundColorred() -> UIColor {
        return UIColor(hexString: "#FF4D4F")
    }

    static func btnSelBackgroundColorred() -> UIColor {
        return UIColor(hexStringWithAlpha: "#FF4D4F", alpha: 0.3)
    }

    static func btnBackgroundColorf7() -> UIColor {
        return UIColor(hexString: "#F7F7F7")
    }

    static func btnSelBackgroundColorf7() -> UIColor {
        return UIColor(hexStringWithAlpha: "#F7F7F7", alpha: 0.3)
    }

    static func lineViewColor() -> UIColor {
        return UIColor(hexString: "#EAEAEA")
    }

    static func lineViewColor1() -> UIColor {
        return UIColor(hexString: "#1890FF")
    }

    static func lineViewColor2() -> UIColor {
        return UIColor(hexString: "#010101")
    }

    static func lineViewColor3() -> UIColor {
        return UIColor(hexString: "#DBDBDB")
    }

    static func whiteColor() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }

    static func switchBtnOnColor() -> UIColor {
        return UIColor(hexString: "#1890FF")
    }

    static func hubBgColor() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
    }

    static func viewShadowColor() -> CGColor {
        return UIColor(hexStringWithAlpha: "#000000", alpha: 0.3).cgColor
    }

    static func progressColor() -> UIColor {
        return UIColor(hexString: "#1FA3FF")
    }

    static func progressColor2() -> UIColor {
        return UIColor(hexString: "#FE9623")
    }

    static func progressColor3() -> UIColor {
        return UIColor(hexString: "#38BE76")
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255
        let blue = CGFloat(hex & 0x0000FF) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        guard hexString.hasPrefix("#") else {
            fatalError("Invalid hex color string: \(hexString)")
        }
        
        let hex = String(hexString.dropFirst())
        
        guard hex.count == 6 else {
            fatalError("Invalid hex color string: \(hexString)")
        }
        
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(hex: Int(hexNumber), alpha: alpha)
        } else {
            fatalError("Invalid hex color string: \(hexString)")
        }
    }
    
    convenience init(hexStringWithAlpha: String, alpha: CGFloat) {
        guard hexStringWithAlpha.hasPrefix("#") else {
            fatalError("Invalid hex color string: \(hexStringWithAlpha)")
        }
        
        let hexWithAlpha = String(hexStringWithAlpha.dropFirst())
        
        guard hexWithAlpha.count == 6 else {
            fatalError("Invalid hex color string: \(hexStringWithAlpha)")
        }
        
        let hex = String(hexWithAlpha.dropLast(2))
        let alphaHex = String(hexWithAlpha.suffix(2))
        
        guard let alphaValue = UInt8(alphaHex, radix: 16) else {
            fatalError("Invalid hex color string: \(hexStringWithAlpha)")
        }
        
        guard let hexNumber = UInt64(hex, radix: 16) else {
            fatalError("Invalid hex color string: \(hexStringWithAlpha)")
        }
        
        let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let blue = CGFloat(hexNumber & 0x0000FF) / 255
        let alpha = CGFloat(alphaValue) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

func kHexColorA(_ c: UInt32, _ a: CGFloat) -> UIColor {
    let red = CGFloat((c >> 16) & 0xFF) / 255.0
    let green = CGFloat((c >> 8) & 0xFF) / 255.0
    let blue = CGFloat(c & 0xFF) / 255.0
    return UIColor(red: red, green: green, blue: blue, alpha: a)
}

func kBoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

func kFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func kNameFont(_ size: CGFloat) -> UIFont {
    return UIFont(name: "PingFang SC", size: size)!
}

func kFontRegular(_ fontSize: CGFloat) -> UIFont {
    return UIFont(name: "PingFangSC-Regular", size: fontSize * kScreenScale)!
}

func kFontBold(_ fontSize: CGFloat) -> UIFont {
    return UIFont(name: "PingFangSC-Semibold", size: fontSize * kScreenScale)!
}

func kFontPFMedium(_ fontSize: CGFloat) -> UIFont {
    return UIFont(name: "PingFangSC-Medium", size: fontSize * kScreenScale)!
}

func kUrlString(_ string: String) -> URL {
    return URL(string: string)!
}

func kImageNamed(_ name: String) -> UIImage {
    return UIImage(named: name)!
}

func kString(_ object: Any?) -> String {
    return "\(object ?? "")"
}

let kScreenScale = UIScreen.main.bounds.size.width / 320.0

func kLanguage(_ a: String) -> String {
    return NSLocalizedString(a, comment: "")
}

extension UIFont {
    static func fontWithsystemFont(_ fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    static func fontWithBoldFont(_ fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    static func fontWithPFRegular(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: fontSize * kScreenScale)!
    }
    
    static func fontWithPFSemibold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: fontSize * kScreenScale)!
    }
    
    static func fontWithPFMedium(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: fontSize * kScreenScale)!
    }
}
