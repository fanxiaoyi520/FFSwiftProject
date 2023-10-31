//
//  FFRegisterViewController.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/25.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class FFRegisterViewController: FFBaseViewController {
   
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
    
    lazy var accountTXT: FFTextField = {
        let textField = FFTextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("请输入6-12位新密码")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .unlessEditing
        textField.keyboardType = .default
        let originalImage = UIImage(named: "login_icon_lock")
        let newSize = CGSize(width: 25, height: 25)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let scaledImage = renderer.image { context in
            originalImage?.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
            context.cgContext.setFillColor(UIColor.black.cgColor)
            context.cgContext.setBlendMode(.sourceAtop)
            context.cgContext.fill(CGRect(origin: CGPoint.zero, size: newSize))
        }
        let leftView = UIImageView(image: scaledImage)
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var companyNameTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("公司名称")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .default
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 53))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var codeTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("社会信用代码")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .default
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 53))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var contactsNameTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("联系人姓名")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .default
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 53))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var companyAbbreviationTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("公司简称")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .default
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 53))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var businessAddressTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("营业地址")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.keyboardType = .default
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 53))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(18)
        button.setTitle(kLanguage("注册"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        button.addTarget(self, action: #selector(loginBtnAction(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kLanguage("注册")
        layoutSubViewUI()
    }
    
    func layoutSubViewUI() {
        view.addSubview(phoneTXT)
        view.addSubview(verificationCodeTXT)
        view.addSubview(accountTXT)
        view.addSubview(companyNameTXT)
        view.addSubview(codeTXT)
        view.addSubview(contactsNameTXT)
        view.addSubview(companyAbbreviationTXT)
        view.addSubview(businessAddressTXT)
        view.addSubview(loginBtn)
        addConstraints()
    }
    
    func addConstraints() {
        
        phoneTXT.snp.makeConstraints { make in
            make.top.equalTo(40+getStatusBarAndNavigationBarHeight())
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
        
        accountTXT.snp.makeConstraints { make in
            make.top.equalTo(verificationCodeTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        companyNameTXT.snp.makeConstraints { make in
            make.top.equalTo(accountTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        codeTXT.snp.makeConstraints { make in
            make.top.equalTo(companyNameTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        contactsNameTXT.snp.makeConstraints { make in
            make.top.equalTo(codeTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        companyAbbreviationTXT.snp.makeConstraints { make in
            make.top.equalTo(contactsNameTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        businessAddressTXT.snp.makeConstraints { make in
            make.top.equalTo(companyAbbreviationTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(businessAddressTXT.snp.bottom).offset(32)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(54)
        }
    }
    
    // MARK: - Actions
    @objc func sendVerificationCode() {
        view.endEditing(true)
        guard let phoneNumber = phoneTXT.text, !phoneNumber.isEmpty else {
            self.view.showToast(message: kLanguage("请输入手机号"))
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
    
    @objc func loginBtnAction(_ sender: UIButton) {
        
        guard loginCheck() else { return }
        registerAccount()
    }
    
    func loginCheck() -> Bool {
        view.endEditing(true)
        
        guard let phoneTXT = phoneTXT.text,!phoneTXT.isEmpty else {
            self.view.showToast(message: kLanguage("手机号不能为空"))
            return false
        }
        
        guard let verificationCodeTXT = verificationCodeTXT.text,!verificationCodeTXT.isEmpty else {
            self.view.showToast(message: kLanguage("验证码不能为空"))
            return false
        }
 
        guard let accountTXT = accountTXT.text,!accountTXT.isEmpty else {
            self.view.showToast(message: kLanguage("密码不能为空"))
            return false
        }
        
        return true
    }
    
}

extension FFRegisterViewController {
    
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


extension FFRegisterViewController {
    
    func registerAccount() -> Void {
     
        let parameters: [String : Any] = [
            "account": self.phoneTXT.text ?? "",
            "phone": self.phoneTXT.text ?? "",
            "smsCode": verificationCodeTXT.text ?? "",
            "password": accountTXT.text ?? "",
            "companyId": codeTXT.text ?? "",
            "companyName": companyNameTXT.text ?? "",
            "contact": contactsNameTXT.text ?? "",
            "storeName": companyAbbreviationTXT.text ?? "",
            "companyAddress": businessAddressTXT.text ?? "",
            "companyAddressX": 0,
            "companyAddressY": 0,
            "inviteCode": "string",
            "wxOpenId": "string"
            ]
        NetworkManager.shared.request(url: MerchantRegister,
                                      method: .post,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<TokenModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            ToastManager.shared.showToast(message: response.message ?? "注册成功")
            debugPrint("====token：\(String(describing: response.data))")
            self.navigationController?.popViewController(animated: true)
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}

