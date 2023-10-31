//
//  FFLoginViewController.swift
//  FFAcssell
//
//  Created by zhou on 2019/8/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import SnapKit
import RZColorfulSwift

class FFLoginViewController: FFBaseViewController {
    
    // MARK: - Getting
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_logo")
        return imageView
    }()
    
    lazy var loginView: FFLoginView = {
        let loginView = FFLoginView()
        loginView.delegate = self
        return loginView
    }()
    
    let selAutoBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_unselected"), for: .normal)
        button.setImage(UIImage(named: "ic_selected"), for: .selected)
        return button
    }()
    
    let titleAutoLab : UILabel = {
        let label = UILabel()
        label.textColor = Theme.titleColor()
        label.numberOfLines = 0
        label.text = kLanguage("自动登陆")
        return label
    }()
    
    let forgetPwdBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("忘记密码", for: .normal)
        button.setTitleColor(Theme.btnBackgroundColor(), for: .normal)
        return button
    }()
    
    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(18)
        button.setTitle(kLanguage("登录"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        button.addTarget(self, action: #selector(loginBtnAction(_:)), for: .touchUpInside)
        return button
    }()
        
    let selBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_unselected"), for: .normal)
        button.setImage(UIImage(named: "ic_selected"), for: .selected)
        return button
    }()
    
    let titleLab : UILabel = {
        let label = UILabel()
        label.textColor = Theme.titleColor()
        label.numberOfLines = 0
        return label
    }()
    
    let tipsLab : UILabel = {
        let label = UILabel()
        label.textColor = Theme.subTitleColor()
        label.text = kLanguage("copyright @ 2023 柏川软件")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let registerBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("注册账户", for: .normal)
        button.setTitleColor(Theme.btnBackgroundColor(), for: .normal)
        return button
    }()
    
    var selIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSubViewUI()
    }
    
    func layoutSubViewUI() {
        view.addSubview(logoImageView)
        view.addSubview(loginView)
        view.addSubview(selAutoBtn)
        view.addSubview(titleAutoLab)
        view.addSubview(forgetPwdBtn)
        view.addSubview(loginBtn)
        view.addSubview(selBtn)
        view.addSubview(titleLab)
        view.addSubview(tipsLab)
        view.addSubview(registerBtn)
        addConstraints()
    }
    
    
    
    func addConstraints() {
        let ratio = 100
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(122)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(ratio)
        }
        loginView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(logoImageView.snp.bottom).offset(57)
            make.height.equalTo(53*3+12*2)
        }
        selAutoBtn.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(20)
            make.left.equalTo(27.5)
            make.width.height.equalTo(25)
        }
        titleAutoLab.snp.makeConstraints { make in
            make.left.equalTo(selAutoBtn.snp.right).offset(10)
            make.right.equalTo(-27.5)
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalTo(selAutoBtn)
        }
        forgetPwdBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalTo(selAutoBtn)
            make.width.greaterThanOrEqualTo(80)
        }
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(65)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(54)
        }
        selBtn.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(20)
            make.left.equalTo(27.5)
            make.width.height.equalTo(25)
        }
        
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(selBtn.snp.right).offset(10)
            make.right.equalTo(-27.5)
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalTo(selBtn)
        }
        
        titleLab.rz.colorfulConfer { confer in
            confer.text("我已阅读并同意")?.font(.systemFont(ofSize: 15)).textColor(.black)
            confer.text("《服务协议》")?.font(.systemFont(ofSize: 15)).textColor(Theme.btnBackgroundColor()).tapActionByLable("100").paragraphStyle?.alignment(.left)
            confer.text(" 和 ")?.font(.systemFont(ofSize: 15)).textColor(.black)
            confer.text("《隐私政策》")?.font(.systemFont(ofSize: 15)).textColor(Theme.btnBackgroundColor()).tapActionByLable("101").paragraphStyle?.alignment(.center)
        }
        
        titleLab.rz.tapAction { label, tapActionId,arg  in
            print("tapActionId:\(tapActionId)")
            let vc = FFPolicyViewController()
            vc.titleStr = tapActionId == "100" ? "服务协议" : "隐私政策"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tipsLab.snp.makeConstraints { make in
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalTo(-80)
        }
        
        registerBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(20)
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(20)
            make.width.greaterThanOrEqualTo(80)
        }
        
        selBtn.addTarget(self, action: #selector(selBtnAction(_:)), for: .touchUpInside)
        selAutoBtn.addTarget(self, action: #selector(selAutoBtnAction(_:)), for: .touchUpInside)
        forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnAction(_:)), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(registerBtnAction(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func selAutoBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func loginBtnAction(_ sender: UIButton) {
        guard loginCheck() else { return }
        
        var txt0 = ""
        var txt1 = ""
        var parameters : [String : Any] = [:]
        if (selIndex == 0) {
            txt0 = self.loginView.accountAndPwdLoginView.accountTXT.text ?? ""
            txt1 = self.loginView.accountAndPwdLoginView.passwordTXT.text ?? ""
            parameters = [
                "username": txt0,
                "password": txt1,
                "loginIdentity":1,
                "loginPort": 1,
            ]
        } else {
            txt0 = self.loginView.codeLoginView.phoneTXT.text ?? ""
            txt1 = self.loginView.codeLoginView.verificationCodeTXT.text ?? ""
            parameters = [
                "phone": txt0,
                "smsCode": txt1,
                "loginIdentity":1,
                "loginPort": 2,
            ]
        }
        FFUserManager.shared.login(loginType: .UserLoginTypeIsPassword, params: parameters) { (success, description) in
            if success {
                debugPrint(success)
            }
        }
    }
    
    func loginCheck() -> Bool {
        view.endEditing(true)
        if (!selBtn.isSelected) {
            self.view.showToast(message: kLanguage("请同意《服务协议》和《隐私政策》，我们才能为您服务"))
            return false
        }
        
        if (selIndex == 0) {
            guard let accountTXT = self.loginView.accountAndPwdLoginView.accountTXT.text,!accountTXT.isEmpty else {
                self.view.showToast(message: kLanguage("账号不能为空"))
                return false
            }
            
            guard let passwordTXT = self.loginView.accountAndPwdLoginView.passwordTXT.text,!passwordTXT.isEmpty else {
                self.view.showToast(message: kLanguage("密码不能为空"))
                return false
            }
        } else {
            guard let accountTXT = self.loginView.codeLoginView.phoneTXT.text,!accountTXT.isEmpty else {
                self.view.showToast(message: kLanguage("手机号不能为空"))
                return false
            }
            
            guard let passwordTXT = self.loginView.codeLoginView.verificationCodeTXT.text,!passwordTXT.isEmpty else {
                self.view.showToast(message: kLanguage("验证码不能为空"))
                return false
            }
        }
        
        return true
    }
    
    @objc func selBtnAction(_ sender:UIButton) -> Void {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func registerBtnAction(_ sender:UIButton) -> Void {
        let vc = FFRegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func forgetPwdBtnAction(_ sender:UIButton) -> Void {
        let vc = FFForgetPwdViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FFLoginViewController : FFLoginViewDelegate {
    func loginViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selIndex = indexPath.row
    }
    
    func loginViewSelectIndex(index: Int) {
        selIndex = index
    }
}
