//
//  FFAccountAndPwdLoginView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/30.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class FFAccountAndPwdLoginView : UIView {
    
    lazy var accountTXT: FFTextField = {
        let textField = FFTextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("请输入您的账号")
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.clearButtonMode = .whileEditing
        let leftView = UIImageView(image: UIImage(named: "login_icon_user"))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var passwordTXT: FFTextField = {
        let textField = FFTextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("请输入登录密码")
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
        let leftView = UIImageView(image: UIImage(named: "login_icon_lock"))
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.addSubview(accountTXT)
        self.addSubview(passwordTXT)

        accountTXT.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
        passwordTXT.snp.makeConstraints { make in
            make.top.equalTo(accountTXT.snp.bottom).offset(12)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(53)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

