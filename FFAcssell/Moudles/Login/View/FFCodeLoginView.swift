//
//  FFCodeLoginView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/30.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class FFCodeLoginView : UIView {
    
    // MARK: - Getting
    lazy var phoneTXT: FFTextField = {
        let textField = FFTextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("手机号")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .numberPad
        let originalImage = UIImage(named: "mine_phone_call")

        let newSize = CGSize(width: 25, height: 25)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let scaledImage = renderer.image { _ in
            originalImage?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }

        let leftView = UIImageView(image: scaledImage)
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()

    lazy var verificationCodeTXT: FFTextField = {
        let textField = FFTextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("验证码")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .numberPad
        let originalImage = UIImage(named: "mine_check")
        let newSize = CGSize(width: 25, height: 25)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let scaledImage = renderer.image { _ in
            originalImage?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }

        let leftView = UIImageView(image: scaledImage)
        textField.leftView = leftView
        textField.leftViewMode = .always
        let rightView = UIButton(type: .custom)
        rightView.frame = CGRect(x: 0, y: 0, width: 80, height: textField.bounds.height)
        rightView.setTitle(kLanguage("发送验证码"), for: .normal)
        rightView.titleLabel?.font = kFontRegular(15)
        rightView.setTitleColor(Theme.titleColor(), for: .normal)
        rightView.addTarget(self, action: #selector(sendVerificationCode), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()

    var countdownTimer: Timer?
    var remainingTime: Int = 60
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubViewUI()
    }
    
    func layoutSubViewUI() {
        self.addSubview(phoneTXT)
        self.addSubview(verificationCodeTXT)
        addConstraints()
    }
    
    func addConstraints() {
        
        phoneTXT.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        verificationCodeTXT.snp.makeConstraints { make in
            make.top.equalTo(phoneTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func sendVerificationCode() {
        self.endEditing(true)
        guard let phoneNumber = phoneTXT.text, !phoneNumber.isEmpty else {
            self.showToast(message: kLanguage("请输入手机号"))
            return
        }
        
        // 调用发送验证码接口发送验证码，具体实现根据你的需求来进行编写
        getCode()
    }
    
    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                
                // 更新按钮文本，显示倒计时时间
                guard let rightView = self.verificationCodeTXT.rightView as? UIButton else {
                    return
                }
                rightView.setTitle("\(self.remainingTime)s", for: .normal)
                rightView.isEnabled = false
            } else {
                self.stopCountdown()
            }
        }
    }

    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        remainingTime = 60
        
        // 更新按钮文本，恢复原始状态
        guard let rightView = self.verificationCodeTXT.rightView as? UIButton else {
            return
        }
        rightView.setTitle(kLanguage("发送验证码"), for: .normal)
        rightView.isEnabled = false
    }
}

extension FFCodeLoginView {
    
    func getCode() -> Void {
        let parameters = [
            "PhoneNumber":phoneTXT.text ?? ""
        ] as [String : Any]
        
        NetworkManager.shared.request(url: GetCode,
                                      method: .get,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<TokenModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            self.startCountdown()
            debugPrint("====获取校验码：\(String(describing: response.data))")
            ToastManager.shared.showToast(message: kLanguage("已发送验证码"))
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}
