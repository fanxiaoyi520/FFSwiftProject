//
//  FFCustomPopupView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/16.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit

protocol FFCustomPopupViewDelegate : AnyObject {
    func customPopupViewSureBtn(sender:UIButton,model:FFShoppingCartModel)
}

class FFCustomPopupView: FWPopupView {
        
    weak var delegate : FFCustomPopupViewDelegate?
    
    var num : Int64 = 1
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithBoldFont(16)
        label.text = kLanguage("新增项目")
        label.textAlignment = .center
        return label
    }()
    
    let titleLab0: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithBoldFont(16)
        label.text = kLanguage("名称")
        return label
    }()
    
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithBoldFont(16)
        label.text = kLanguage("单价")
        return label
    }()
    
    let titleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontWithBoldFont(16)
        label.text = kLanguage("数量")
        return label
    }()
    
    let nameTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let priceTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 22.0
        textField.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        textField.layer.shadowOffset = CGSize.zero
        textField.layer.shadowOpacity = 1.0
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let numbgView: UIView = {
        let view = UIView()
        view.layer.borderColor = Theme.subTitleColor().cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let reduceBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let numTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.font = kFontRegular(15)
        textField.textAlignment = .center
        textField.text = "1"
        textField.isEnabled = false
        return textField
    }()
    
    let addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let sureBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let lineView0: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(titleLab)
        self.addSubview(titleLab0)
        self.addSubview(titleLab1)
        self.addSubview(titleLab2)
        self.addSubview(nameTXT)
        self.addSubview(priceTXT)
        self.addSubview(numbgView)
        numbgView.addSubview(reduceBtn)
        numbgView.addSubview(addBtn)
        numbgView.addSubview(numTXT)
        self.addSubview(cancelBtn)
        self.addSubview(sureBtn)
        self.addSubview(lineView0)
        self.addSubview(lineView1)

        
        titleLab.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(12)
            make.centerX.equalTo(self)
        }
        
        titleLab0.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(titleLab.snp.bottom).offset(32)
            make.left.equalTo(25)
            make.width.lessThanOrEqualTo(50)
        }
        
        titleLab1.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(titleLab0.snp.bottom).offset(32)
            make.left.equalTo(25)
            make.width.lessThanOrEqualTo(50)
        }
        
        titleLab2.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(titleLab1.snp.bottom).offset(32)
            make.left.equalTo(25)
            make.width.lessThanOrEqualTo(50)
        }
        
        nameTXT.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.centerY.equalTo(titleLab0)
            make.right.equalTo(-25)
            make.left.equalTo(titleLab0.snp.right).offset(10)
        }
        
        priceTXT.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.centerY.equalTo(titleLab1)
            make.right.equalTo(-25)
            make.left.equalTo(titleLab1.snp.right).offset(10)
        }
        
        numbgView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.centerY.equalTo(titleLab2)
            make.right.equalTo(-25)
            make.left.equalTo(titleLab2.snp.right).offset(10)
        }
        
        reduceBtn.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.left.equalTo(0)
            make.centerY.equalToSuperview()
        }
        
        addBtn.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.right.equalTo(0)
            make.centerY.equalToSuperview()
        }
        
        numTXT.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.left.equalTo(reduceBtn.snp.right)
            make.right.equalTo(addBtn.snp.left)
            make.centerY.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.width.equalTo(self.frame.size.width/2)
            make.height.equalTo(50)
            make.left.equalTo(self)
            make.top.equalTo(numbgView.snp.bottom).offset(12)
        }
        
        sureBtn.snp.makeConstraints { make in
            make.width.equalTo(self.frame.size.width/2)
            make.height.equalTo(50)
            make.right.equalTo(self)
            make.top.equalTo(numbgView.snp.bottom).offset(12)
        }
        
        lineView0.snp.makeConstraints { make in
            make.width.equalTo(self.frame.size.width)
            make.height.equalTo(1)
            make.top.equalTo(numbgView.snp.bottom).offset(11)
        }
        
        lineView1.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
            make.top.equalTo(numbgView.snp.bottom).offset(11)
        }
        
        addBtn.addTarget(self, action: #selector(addBtn(_:)), for: .touchUpInside)
        reduceBtn.addTarget(self, action: #selector(reduceBtn(_:)), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtn(_:)), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sureBtn(_:)), for: .touchUpInside)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    @objc func addBtn(_ sender:UIButton) -> Void {
        num += 1
        numTXT.text = "\(num)"
    }
    
    @objc func reduceBtn(_ sender:UIButton) -> Void {
        num -= 1
        if (num < 1) {num = 1}
        numTXT.text = "\(num)"
    }
    
    @objc func cancelBtn(_ sender:UIButton) -> Void {
        self.hide()
    }
    
    @objc func sureBtn(_ sender:UIButton) -> Void {
        
        guard let price = priceTXT.text,!price.isEmpty else {
            ToastManager.shared.showToast(message: kLanguage("请输入价格"),position: .center)
            return
        }
        
        guard let name = nameTXT.text,!name.isEmpty else {
            ToastManager.shared.showToast(message: kLanguage("请输入名称"),position: .center)
            return
        }
        
        let model = FFShoppingCartModel()
        model.num = num
        model.price = Float(priceTXT.text ?? "0")
        model.name = nameTXT.text
        model.id = generateRandomID()
        model.istemporary = true
        model.typeStr = "item"
        if self.delegate != nil {
            self.delegate?.customPopupViewSureBtn(sender: sender,model:model)
        }
        self.hide()
    }
}

func generateRandomID() -> Int64 {
    let timestamp = Date().timeIntervalSince1970
    let randomNum = arc4random_uniform(UInt32.max)
    let id = Int64(timestamp) * 10000000 + Int64(randomNum)
    return id
}
