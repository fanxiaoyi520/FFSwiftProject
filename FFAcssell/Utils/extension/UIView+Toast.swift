//
//  UIView+Toast.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/8.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIView {
    func showToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.makeToast(message, duration: duration, position: position)
    }
    
    func showSuccessToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.makeToast(message, duration: duration, position: position, title: "成功", image: UIImage(named: "success_icon"))
    }
    
    func showErrorToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.makeToast(message, duration: duration, position: position, title: "错误", image: UIImage(named: "error_icon"))
    }
}

class ToastManager {
    static let shared = ToastManager()
    
    var currentWindow: UIWindow?

    lazy var toastWindow: UIWindow = {
        let window = getCurrentWindow()
        
        return window ?? currentWindow!
    }()
    
    private init() {}
    
    func showToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.toastWindow.makeToast(message, duration: duration, position: position)
    }
    
    func showSuccessToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.toastWindow.makeToast(message, duration: duration, position: position, title: "成功", image: UIImage(named: "success_icon"))
    }
    
    func showErrorToast(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.toastWindow.makeToast(message, duration: duration, position: position, title: "错误", image: UIImage(named: "error_icon"))
    }
    
    private func getCurrentWindow() -> UIWindow? {
        if let currentWindow = UIApplication.shared.keyWindow {
            return currentWindow
        }
        let windows = UIApplication.shared.windows
        if let visibleWindow = windows.first(where: { !$0.isHidden && $0.alpha > 0 && $0.windowLevel >= UIWindow.Level.normal }) {
            return visibleWindow
        }
        return nil
    }
}
