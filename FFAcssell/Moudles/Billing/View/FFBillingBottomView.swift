//
//  FFBillingBottomView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/12.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import RZCarPlateNoTextField

protocol FFBillingBottomViewDelegate : AnyObject {
    func saveBtnAction(sender:UIButton)
    func checkoutBtnAction(sender:UIButton)
}

class FFBillingBottomView: UIView {

    weak var delegate : FFBillingBottomViewDelegate?
    
    let titleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("合计:")
        label.textAlignment = .right
        return label
    }()
    
    let subTitleLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.red
        label.textAlignment = .right
        label.text = kLanguage("0")
        return label
    }()
    
    let saveBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 15
        button.titleLabel?.font = kFontRegular(18)
        button.setTitle(kLanguage("保存"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        return button
    }()
    
    let checkoutBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 15
        button.titleLabel?.font = kFontRegular(18)
        button.setTitle(kLanguage("结账"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        return button
    }()
    
    @objc func saveBtnAction(_ sender:UIButton) -> Void {
        if self.delegate != nil {
            self.delegate?.saveBtnAction(sender: sender)
        }
    }
    
    @objc func checkoutBtnAction(_ sender:UIButton) -> Void {
        if self.delegate != nil {
            self.delegate?.checkoutBtnAction(sender: sender)
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        self.addSubview(subTitleLab)
        self.addSubview(titleLab)
        self.addSubview(saveBtn)
        self.addSubview(checkoutBtn)
        saveBtn.addTarget(self, action: #selector(saveBtnAction(_:)), for: .touchUpInside)
        checkoutBtn.addTarget(self, action: #selector(checkoutBtnAction(_:)), for: .touchUpInside)

        subTitleLab.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(12)
        }
        
        titleLab.snp.makeConstraints { make in
            make.right.equalTo(subTitleLab.snp.left).offset(-5)
            make.height.greaterThanOrEqualTo(20)
            make.centerY.equalTo(subTitleLab)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(25)
            make.height.equalTo(44)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
            make.width.equalTo((getScreenWidth()-25*2-100)/2)
        }
        
        checkoutBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.height.equalTo(44)
            make.top.equalTo(titleLab.snp.bottom).offset(12)
            make.width.equalTo((getScreenWidth()-25*2-100)/2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: public
    func update(model:FFOrderModel,allNum:Int64) -> Void {
        
        let totalPrice0 = model.productInfos.reduce(0.0) { $0 + $1.smallSum}
        let totalPrice1 = model.itemInfos.reduce(0.0) { $0 + $1.smallSum}

        subTitleLab.text = "\(totalPrice0+totalPrice1)"
        let num0 = model.productInfos.reduce(0) { $0 + $1.qty}
        let num1 = model.itemInfos.reduce(0) { $0 + $1.qty}
        let all = abs(num0)+abs(num1) != allNum ? Int(allNum) : abs(num0)+abs(num1)
        //let all = abs(num0)+abs(num1)
        titleLab.text = "数量: \(all)件,金额:"
    }
}
