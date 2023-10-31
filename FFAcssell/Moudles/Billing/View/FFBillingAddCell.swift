//
//  FFBillingAddCell.swift
//  FFAcssell
//
//  Created by YYZS on 2023/10/13.
//  Copyright © 2023 MissZhou. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AEAlertView

protocol FFBillingAddCellDelegate : AnyObject {
    func updateItem(item:FFShoppingCartModel)
}

class FFBillingAddCell: UITableViewCell {
        
    weak var delegate : FFBillingAddCellDelegate?
    
    // 标题标签
    let titleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("项目:")
        label.textColor = Theme.btnBackgroundColor()
        return label
    }()
    
    let titleLab2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("单价:")
        return label
    }()
    
    let titleLab3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = kLanguage("数量:")
        return label
    }()
    
    let reduceBtn: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = false
        button.layer.borderWidth = 1
        button.layer.borderColor = Theme.subTitleColor().cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let sumTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.font = kFontRegular(15)
        textField.textAlignment = .center
        textField.text = "1"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let addBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = false
        button.layer.borderWidth = 1
        button.layer.borderColor = Theme.subTitleColor().cgColor
        return button
    }()
    
    // 子标题标签
    let subTitleLab1: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Theme.btnBackgroundColor()
        return label
    }()

    let subTitleTXT: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Theme.whiteColor()
        textField.font = kFontRegular(15)
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Theme.subTitleColor().cgColor
        textField.keyboardType = .numberPad
        textField.isEnabled = false
        return textField
    }()

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.lineViewColor()
        return view
    }()
    
    var item: FFShoppingCartModel? {
        didSet {
            guard let item = item else { return }
            subTitleLab1.text = item.name
            subTitleTXT.text = "\(item.price ?? 0.0)"
            sumTXT.text = "\(item.num)"
            if (item.istemporary) {
                titleLab1.text = "临时:"
                titleLab1.textColor = UIColor.red
                subTitleLab1.textColor = UIColor.red
            } else {
                titleLab1.text = item.typeStr == "product" ? kLanguage("商品:") : kLanguage("项目:")
                titleLab1.textColor = Theme.btnBackgroundColor()
                subTitleLab1.textColor = Theme.btnBackgroundColor()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加标题标签
        contentView.addSubview(titleLab1)
        contentView.addSubview(titleLab2)
        contentView.addSubview(titleLab3)

        // 添加子标题标签
        contentView.addSubview(subTitleLab1)
        contentView.addSubview(subTitleTXT)
        contentView.addSubview(addBtn)
        contentView.addSubview(sumTXT)
        contentView.addSubview(reduceBtn)

        contentView.addSubview(lineView)
        
        // 设置标题标签约束（靠左边距 25，并垂直居中）
        titleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(contentView).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        titleLab2.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(25)
            make.top.equalTo(titleLab1.snp.bottom).offset(12)
            make.height.greaterThanOrEqualTo(20)
        }
        
        // 设置子标题标签约束（靠右边距 25，并垂直居中）
        subTitleLab1.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab1.snp.right).offset(10)
            make.centerY.equalTo(titleLab1)
            make.height.greaterThanOrEqualTo(20)
        }
        
        subTitleTXT.snp.makeConstraints { (make) in
            make.left.equalTo(titleLab2.snp.right).offset(10)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
            make.width.equalTo(100)
        }
        
        titleLab3.snp.makeConstraints { (make) in
            make.left.equalTo(subTitleTXT.snp.right).offset(60)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
        }
        
        addBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-25)
            make.centerY.equalTo(titleLab2)
            make.width.height.equalTo(28)
        }
        
        sumTXT.snp.makeConstraints { (make) in
            make.right.equalTo(addBtn.snp.left)
            make.centerY.equalTo(titleLab2)
            make.height.greaterThanOrEqualTo(20)
            make.width.equalTo(60)
        }
        
        reduceBtn.snp.makeConstraints { (make) in
            make.right.equalTo(sumTXT.snp.left)
            make.centerY.equalTo(titleLab2)
            make.width.height.equalTo(28)
        }
        
        lineView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 79, left: 25, bottom: 0, right: 0))
        }
        
        reduceBtn.addTarget(self, action: #selector(reduceBtn(_:)), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(addBtn(_:)), for: .touchUpInside)
        sumTXT.addTarget(self, action: #selector(sumTXT(_:)), for: .editingChanged)
        sumTXT.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: actions
    @objc func sumTXT(_ textField:UITextField) -> Void {
        guard let num = Int64(textField.text ?? "1") else {
            debugPrint("无法将字符串转换为整型")
            return
        }
        
        item?.num  = num
        if self.delegate != nil {
            self.delegate?.updateItem(item: item ?? FFShoppingCartModel())
        }
    }
    
    @objc func reduceBtn(_ sender:UIButton) -> Void {
        item?.num -= 1
        if (item?.num ?? 0 < 1) {
            AEAlertView.show(title: "", message: "删除此商品？", actions: ["取消","确定"]) { action in
                if (action.tag == 1) {
                    self.item?.num = 0
                    self.sumTXT.text = "\(self.item?.num ?? 0)"
                    if self.delegate != nil {
                        self.delegate?.updateItem(item: self.item ?? FFShoppingCartModel())
                    }
                }
                self.item?.num = 1
                self.sumTXT.text = "\(self.item?.num ?? 0)"
                if self.delegate != nil {
                    self.delegate?.updateItem(item: self.item ?? FFShoppingCartModel())
                }
            }
        } else {
            sumTXT.text = "\(item?.num ?? 0)"
            if self.delegate != nil {
                self.delegate?.updateItem(item: item ?? FFShoppingCartModel())
            }
        }
    }
    
    @objc func addBtn(_ sender:UIButton) -> Void {
        item?.num += 1
        sumTXT.text = "\(item?.num ?? 0)"
        if self.delegate != nil {
            self.delegate?.updateItem(item: item ?? FFShoppingCartModel())
        }
    }
}

extension FFBillingAddCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text == "" || textField.text == nil) {
            textField.text = "1"
            item?.num = 1
        }
    }
}
