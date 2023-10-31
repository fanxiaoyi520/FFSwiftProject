//
//  CommonConst.swift
//  FFAcssell
//
//  Created by zhou on 2019/7/31.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 登录状态相关
///登录状态改变通知
let kNotificationLoginStateChange = "FFLoginStateChange"

///自动登录成功
let kNotificationAutoLoginSuccess = "FFAutoLoginSuccess"


// MARK: - 网络状态相关
///网络状态改变
let kNotificationNetWorkingStateChange = "FFNetWorkingStateChange"


func getScreenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

func getScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

func getScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

// 获取状态栏高度
func getStatusBarHeight() -> CGFloat {
    return UIApplication.shared.statusBarFrame.height
}

// 获取导航栏高度
func getNavigationBarHeight() -> CGFloat {
    guard let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
        return 0
    }
    return navigationController.navigationBar.frame.height
}

// 获取安全区高度
func getSafeAreaHeight() -> CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.bottom ?? 0
    } else {
        return 0
    }
}

// 获取 TabBar 高度
func getTabBarHeight() -> CGFloat {
    guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
        return 0
    }
    return tabBarController.tabBar.frame.height
}

// 获取状态栏和导航栏总高度
func getStatusBarAndNavigationBarHeight() -> CGFloat {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    var statusBarHeight: CGFloat = 0.0
    if #available(iOS 13.0, *) {
        let statusBarManager = window?.windowScene?.statusBarManager
        statusBarHeight = statusBarManager?.statusBarFrame.height ?? 0.0
    } else {
        statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    
    var navBarHeight: CGFloat = 0.0
    if let topVC = window?.rootViewController {
        if let navController = topVC as? UINavigationController {
            navBarHeight = navController.navigationBar.frame.height
        } else if let tabBar = topVC as? UITabBarController, let navController = tabBar.selectedViewController as? UINavigationController {
            navBarHeight = navController.navigationBar.frame.height
        }
    }
    
    return statusBarHeight + navBarHeight
}

func isTelNumber(num:String)->Bool
{
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: num) == true)
        || (regextestcm.evaluate(with: num)  == true)
        || (regextestct.evaluate(with: num) == true)
        || (regextestcu.evaluate(with: num) == true))
    {
        return true
    }
    else
    {
        return false
    }
}
