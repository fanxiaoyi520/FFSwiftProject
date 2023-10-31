//
//  FFOrderDetailsHeaderView.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FFOrderDetailsHeaderView: UITableViewHeaderFooterView {
    
    // 标题标签
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("订单号:")
        return label
    }()
    
    let titleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("客   户:")
        return label
    }()
    
    let titleLab3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("电   话:")
        return label
    }()

    let titleLab4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("车   牌:")
        return label
    }()
    
    // 子标题标签
    let subTitleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let subTitleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let subTitleLab3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        label.textColor = Theme.btnBackgroundColor()
        return label
    }()
    
    let subTitleLab4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Theme.subTitleColor()
        label.textAlignment = .right
        return label
    }()
    
    let priceLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.red
        label.textAlignment = .right
        return label
    }()
    
    var item: FFOrderDetailsModel? {
        didSet {
            guard let item = item else { return }
            subTitleLab1.text = "\(item.orderId ?? 0000)"
            subTitleLab2.text = item.customerName ?? "暂无"
            subTitleLab3.text = item.customerPhone?.isEmpty == true ? "--": item.customerPhone
            subTitleLab4.text = item.carNum ?? "暂无"
            timeLab.text = item.createTime ?? "暂无"            
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // 添加标题标签
        contentView.addSubview(titleLab1)
        contentView.addSubview(titleLab2)
        contentView.addSubview(titleLab3)
        contentView.addSubview(titleLab4)

        // 添加子标题标签
        contentView.addSubview(subTitleLab1)
        contentView.addSubview(subTitleLab2)
        contentView.addSubview(subTitleLab3)
        contentView.addSubview(subTitleLab4)
        contentView.addSubview(timeLab)
        contentView.addSubview(priceLab)

        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(phoneTapAction))
        subTitleLab3.addGestureRecognizer(phoneTap)
        
        // 设置标题标签约束（靠左边距 25，并垂直居中）
        titleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(titleLab1.snp.bottom).offset(6)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab3.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(titleLab2.snp.bottom).offset(6)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab4.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(titleLab3.snp.bottom).offset(6)
            make.height.greaterThanOrEqualTo(20)
        }
        
        // 设置子标题标签约束（靠右边距 25，并垂直居中）
        subTitleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab1.snp.right).offset(10)
            make.centerY.equalTo(titleLab1)
            make.height.greaterThanOrEqualTo(20)
        }
        
        subTitleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab2.snp.right).offset(10)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
        }
        
        subTitleLab3.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab3.snp.right).offset(10)
            make.centerY.equalTo(titleLab3)
            make.height.greaterThanOrEqualTo(20)
        }
        
        subTitleLab4.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab4.snp.right).offset(10)
            make.centerY.equalTo(titleLab4)
            make.height.greaterThanOrEqualTo(20)
        }
        
        timeLab.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-25)
            make.top.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        priceLab.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-25)
            make.top.equalTo(timeLab.snp.bottom).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func phoneTapAction(tap:UITapGestureRecognizer) {
        guard let phone = item?.customerPhone,!phone.isEmpty else { return }
        if let phoneURL = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
}
