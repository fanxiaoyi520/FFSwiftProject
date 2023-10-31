//
//  FFBillingHeaderView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/12.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import RZCarPlateNoTextField

protocol FFBillingHeaderViewDelegate: AnyObject {
    func billingHeaderViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func rz_textFieldEditingValueChanged(textField: RZCarPlateNoTextField) -> Void
    func selBtnNoLicense(sender: UIButton) -> Void
    func billingHeaderViewSaveBtnAction(sender: UIButton) -> Void
    func addProject(sender:UIButton)
}

class FFBillingHeaderView: UITableViewHeaderFooterView {

    weak var delegate : FFBillingHeaderViewDelegate?
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("车牌号")
        return label
    }()
    
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("手机号")
        label.isHidden = true
        return label
    }()
    
    lazy var textField: RZCarPlateNoTextField = {
        let textfield = RZCarPlateNoTextField()
        textfield.rz_maxLength = 0
        textfield.rz_checkCarPlateNoValue = true
        textfield.placeholder = kLanguage("请输入车牌号")
        textfield.backgroundColor = Theme.whiteColor()
        textfield.font = kFontRegular(15)
        textfield.layer.cornerRadius = 12
        textfield.layer.masksToBounds = false
        textfield.layer.shadowRadius = 22.0
        textfield.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textfield.layer.shadowOffset = CGSize.zero
        textfield.layer.shadowOpacity = 1.0
        textfield.clearButtonMode = .whileEditing
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textfield.leftViewMode = .always
        textfield.rz_regexPlateNoIfYouNeed = { (text: String) -> String in
            return text
        }

        textfield.rz_textFieldEditingValueChanged = { (textField: RZCarPlateNoTextField) in
            debugPrint("输入变化回调：\(String(describing: textField.text))")
            if let delegate = self.delegate {
                self.delegate?.rz_textFieldEditingValueChanged(textField: textField)
            }
        }

        // 调用 rz_changeKeyBoard(_:) 方法来控制键盘的显示模式，参数传入false表示显示字母键盘，传入true表示显示省份键盘。
        textfield.rz_changeKeyBoard(false)
        return textfield
    }()
    
    let selBtn: UIButton = {
        let button = UIButton()
        button.setTitle("无牌", for: .normal)
        button.setTitleColor(Theme.btnBackgroundColor(), for: .normal)
        button.setImage(UIImage(named: "ic_unselected"), for: .normal)
        button.setImage(UIImage(named: "ic_selected"), for: .selected)
        button.isSelected = false
        return button
    }()
    
    let accountTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.placeholder = kLanguage("客户手机号")
        textField.font = kFontRegular(13)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.textAlignment = .left
        textField.isHidden = true
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    let saveBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(12)
        button.setTitle(kLanguage("保存客户"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        button.isHidden = true
        return button
    }()
    
    let billingCarouselView = FFBillingCarouselView(dataItems: billingArr(), frame: CGRect(x: 0, y: 80, width: getScreenWidth(), height: 51))

    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.delegate != nil {
            self.delegate?.selBtnNoLicense(sender: sender)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLab)
        contentView.addSubview(titleLab1)
        contentView.addSubview(selBtn)
        contentView.addSubview(textField)
        contentView.addSubview(saveBtn)
        contentView.addSubview(accountTXT)
        
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.left.equalTo(25)
            make.width.lessThanOrEqualTo(50)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab1.snp.makeConstraints { make in
            make.top.equalTo(titleLab.snp.bottom).offset(42)
            make.left.equalTo(25)
            make.width.equalTo(50)
            make.height.greaterThanOrEqualTo(20)
        }

        selBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.right.equalTo(-25)
            make.height.equalTo(50)
            make.width.lessThanOrEqualTo(60)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab)
            make.left.equalTo(titleLab.snp.right).offset(10)
            make.height.equalTo(50)
            make.right.equalTo(selBtn.snp.left).offset(-10)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab1)
            make.right.equalTo(-25)
            make.height.equalTo(34)
            make.width.equalTo(100)
        }
        
        accountTXT.snp.makeConstraints { make in
            make.centerY.equalTo(titleLab1)
            make.left.equalTo(titleLab1.snp.right).offset(10)
            make.height.equalTo(50)
            make.right.equalTo(saveBtn.snp.left).offset(-10)
        }
        
        selBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveBtnAction(_:)), for: .touchUpInside)

        //self.layoutIfNeeded()
        
        contentView.addSubview(billingCarouselView)
        billingCarouselView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveBtnAction(_ sender:UIButton) -> Void {
        if (accountTXT.text == "" || accountTXT.text == nil) {
            ToastManager.shared.showToast(message: kLanguage("请输入手机号"),position: .center)
            return
        }
        
        if (!isTelNumber(num: accountTXT.text ?? "")) {
            ToastManager.shared.showToast(message: kLanguage("请输入正确的手机号码"),position: .center)
            return
        }
        
        if (textField.text == "" || textField.text == nil) {
            ToastManager.shared.showToast(message: kLanguage("请填写车牌号码"),position: .center)
            return
        }
        
        if self.delegate != nil {
            self.delegate?.billingHeaderViewSaveBtnAction(sender: sender)
        }
    }
        
    //MARK: method
    public func updateTabbar(index:Int) -> Void {
        self.billingCarouselView.updateTabbar(index: index)
    }
    
    public func updateContent(licenseModel:FFLicenseModel,completion:(() -> Void)? = nil) -> Void {
        
        if (licenseModel.carNum == "无") {
            self.frame = CGRect(x: 0, y: 0, width: getScreenWidth(), height: 131+62)
            self.billingCarouselView.frame = CGRect(x: 0, y: 80+62, width: getScreenWidth(), height: 51)
            titleLab1.isHidden = false
            accountTXT.isHidden = false
            saveBtn.isHidden = false
        } else {
            self.frame = CGRect(x: 0, y: 0, width: getScreenWidth(), height: 131)
            self.billingCarouselView.frame = CGRect(x: 0, y: 80, width: getScreenWidth(), height: 51)
            titleLab1.isHidden = true
            accountTXT.isHidden = true
            saveBtn.isHidden = true
        }
        completion?()
    }
    
    public func updateNum(num:Int64) -> Void {
        self.billingCarouselView.updateNum(num: num)
    }
}

extension FFBillingHeaderView : FFBillingCarouselViewDelegate {
    func addProject(sender: UIButton) {
        if self.delegate != nil {
            self.delegate?.addProject(sender: sender)
        }
    }
    
    func billingCarouselViewCollectionCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.billingHeaderViewCollectionCollectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
