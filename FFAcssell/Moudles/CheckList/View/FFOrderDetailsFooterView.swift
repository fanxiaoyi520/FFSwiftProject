//
//  FFOrderDetailsFooterView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol FFOrderDetailsFooterViewDelegate:AnyObject {
    func back(sender:UIButton)
}

class FFOrderDetailsFooterView: UITableViewHeaderFooterView {
    
    weak open var delegate : FFOrderDetailsFooterViewDelegate?
    // 标题标签
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let titleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let titleLab3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("实付款:")
        return label
    }()
    
    // 子标题标签
    let subTitleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(18)
        button.setTitle(kLanguage("返回"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        button.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        return button
    }()
    
    var item1: Item? {
        didSet {
            guard item1 != nil else { return }
            if (item1?.statusId == 0) {//未结算
                titleLab2.text = kLanguage("未结算")
                titleLab2.textColor = Theme.subTitleColor()
            } else if (item1?.statusId == 1) {// 已结算
                titleLab2.text = kLanguage("已结算")
                titleLab2.textColor = Theme.titleColor()
            } else if (item1?.statusId == 2) {
                titleLab2.text = kLanguage("已注销")
                titleLab2.textColor = UIColor.red
            } else {
                titleLab2.text = kLanguage("已关闭")
                titleLab2.textColor = UIColor.gray
            }
        }
    }
    
    var item: FFOrderDetailsModel? {
        didSet {
            guard let item = item else { return }
            titleLab1.isHidden = item1?.statusId == 1 ? true : false
            titleLab1.text = "系统生成注销订单_原单\nOrderID_\(String(describing: item.orderId))"
            subTitleLab1.text = "¥\(item.actualAmount ?? 0000)"
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // 添加标题标签
        contentView.addSubview(titleLab1)
        contentView.addSubview(titleLab2)
        // 添加子标题标签
        contentView.addSubview(subTitleLab1)
        contentView.addSubview(titleLab3)
        
        contentView.addSubview(backBtn)
        
        // 设置标题标签约束（靠左边距 25，并垂直居中）
        titleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(150)
            make.top.equalTo(titleLab1.snp.bottom).offset(6)
            make.height.greaterThanOrEqualTo(20)
        }
        
        // 设置子标题标签约束（靠右边距 25，并垂直居中）
        subTitleLab1.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-25)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab3.snp.makeConstraints { (make) in
            make.right.equalTo(subTitleLab1.snp.left).offset(-10)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
        }

        backBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLab3.snp.bottom).offset(20)
            make.left.equalTo(27.5)
            make.right.equalTo(-27.5)
            make.height.equalTo(54)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func back(_ sender:UIButton) -> Void {
        if let delegate = self.delegate {
            delegate.back(sender: sender)
        }
    }
}
