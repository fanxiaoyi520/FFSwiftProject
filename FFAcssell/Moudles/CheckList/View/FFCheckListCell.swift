//
//  FFCheckListCell.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/11.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol FFCheckListCellDelegate : AnyObject {
    func checkListCellEditBtnAction(_ sender:UIButton,cell:UITableViewCell)
    func checkListCellLogOffBtnAction(_ sender:UIButton,cell:UITableViewCell)
}

class FFCheckListCell: UITableViewCell {
    
    weak var delegate : FFCheckListCellDelegate?
    
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
    
    let statusLab: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    let editBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(10)
        button.setTitle(kLanguage("编辑"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        button.isHidden = true
        return button
    }()
    
    let logOffBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.shadowColor = kHexColorA(0x000000, 0.06).cgColor
        button.layer.shadowRadius = 22
        button.titleLabel?.font = kFontRegular(10)
        button.setTitle(kLanguage("注销"), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnBackgroundColor()), for: .normal)
        button.setBackgroundImage(UIImage.createImage(withColor: Theme.btnSelBackgroundColor()), for: .selected)
        button.setTitleColor(Theme.btnTitleColor1(), for: .normal)
        button.setTitleColor(Theme.btnSelTitleColor1(), for: .selected)
        button.isHidden = true
        return button
    }()
    
    var item: Item? {
        didSet {
            guard let item = item else { return }
            subTitleLab1.text = "\(item.orderId ?? 0000)"
            subTitleLab2.text = item.customerName ?? "暂无"
            subTitleLab3.text = item.phone?.isEmpty == true ? "--": item.phone
            subTitleLab4.text = item.carNum ?? "暂无"
            timeLab.text = item.createTime ?? "暂无"
            priceLab.text = "¥\(item.amount ?? 0.0)"
            
            if (item.statusId == 0) {//未结算
                logOffBtn.isHidden = false
                editBtn.isHidden = false
                statusLab.text = kLanguage("未结算")
                statusLab.textColor = Theme.subTitleColor()
                logOffBtn.snp.updateConstraints { (make) in
                    make.right.equalTo(contentView).offset(-25)
                    make.bottom.equalTo(contentView).offset(-12)
                    make.height.equalTo(22)
                    make.width.equalTo(80)
                }
                
                editBtn.snp.updateConstraints { (make) in
                    make.right.equalTo(logOffBtn.snp.left).offset(-25)
                    make.bottom.equalTo(contentView).offset(-12)
                    make.height.equalTo(22)
                    make.centerY.equalTo(logOffBtn)
                    make.width.equalTo(80)
                }
            } else if (item.statusId == 1) {// 已结算
                logOffBtn.isHidden = false
                editBtn.isHidden = true
                statusLab.text = kLanguage("已结算")
                statusLab.textColor = Theme.titleColor()
                logOffBtn.snp.updateConstraints { (make) in
                    make.right.equalTo(contentView).offset(-25)
                    make.bottom.equalTo(contentView).offset(-12)
                    make.height.equalTo(22)
                    make.width.equalTo(80)
                }
            } else if (item.statusId == 2) {// 已注销
                statusLab.text = kLanguage("已注销")
                statusLab.textColor = UIColor.red
                logOffBtn.isHidden = true
                editBtn.isHidden = true
            }  else {
                statusLab.text = kLanguage("已关闭")
                statusLab.textColor = UIColor.gray
                logOffBtn.isHidden = true
                editBtn.isHidden = true
            }
            
            debugPrint("====订单按钮数据:\(String(describing: item.powers))")
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.addSubview(statusLab)
        contentView.addSubview(logOffBtn)
        contentView.addSubview(editBtn)

        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(phoneTapAction))
        subTitleLab3.addGestureRecognizer(phoneTap)

        contentView.addSubview(lineView)
        
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
            make.centerY.equalTo(subTitleLab2)
            make.height.greaterThanOrEqualTo(20)
        }
        
        statusLab.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-25)
            make.centerY.equalTo(subTitleLab3)
            make.height.greaterThanOrEqualTo(20)
        }
        
        logOffBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-25)
            make.bottom.equalTo(contentView).offset(-12)
            make.height.equalTo(22)
            make.width.equalTo(80)
        }
        
        editBtn.snp.makeConstraints { (make) in
            make.right.equalTo(logOffBtn.snp.left).offset(-25)
            make.bottom.equalTo(contentView).offset(-12)
            make.height.equalTo(22)
            make.centerY.equalTo(logOffBtn)
            make.width.equalTo(80)
        }
        
        lineView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 25, bottom: 20.0*4.0+6.0*3.0+12.0*2.0-1, right: 0))
        }
        
        editBtn.addTarget(self, action: #selector(editBtnAction(_:)), for: .touchUpInside)
        logOffBtn.addTarget(self, action: #selector(logOffBtnAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func phoneTapAction(tap:UITapGestureRecognizer) {
        guard let phone = item?.phone,!phone.isEmpty else { return }
        if let phoneURL = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func editBtnAction(_ sender:UIButton) -> Void {
        if self.delegate != nil {
            self.delegate?.checkListCellEditBtnAction(sender,cell: self ?? UITableViewCell())
        }
    }
    
    @objc func logOffBtnAction(_ sender:UIButton) -> Void {
        if self.delegate != nil {
            self.delegate?.checkListCellLogOffBtnAction(sender,cell: self ?? UITableViewCell())
        }
    }
}
